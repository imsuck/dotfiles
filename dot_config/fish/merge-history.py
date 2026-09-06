#!/usr/bin/env python3

# Author: ChatGPT

from __future__ import annotations

import fcntl
import os
import re
import shutil
import sys
import tempfile
from dataclasses import dataclass
from pathlib import Path

HISTORY_DIR = Path(
    os.environ.get(
        "XDG_DATA_HOME",
        Path.home() / ".local" / "share",
    )
) / "fish"

HISTORY_FILE = HISTORY_DIR / "fish_history"

CONFLICT_RE = re.compile(
    rf"^{re.escape(HISTORY_FILE.name)}\.sync-conflict-"
)

ENTRY_START_RE = re.compile(r"^- cmd:")
WHEN_RE = re.compile(r"^  when: (\d+)$")


@dataclass
class Entry:
    text: str
    when: int


def parse_history(path: Path) -> list[Entry]:
    """Parse a Fish history file into entries."""

    try:
        lines = path.read_text(encoding="utf-8").splitlines(keepends=True)
    except FileNotFoundError:
        return []

    entries: list[Entry] = []
    current: list[str] | None = None

    for line in lines:
        if ENTRY_START_RE.match(line):
            if current is not None:
                entries.append(make_entry(current))
            current = [line]
        elif current is not None:
            current.append(line)

    if current is not None:
        entries.append(make_entry(current))

    return entries


def make_entry(lines: list[str]) -> Entry:
    text = "".join(lines)

    when = 0
    for line in lines:
        match = WHEN_RE.match(line.rstrip("\r\n"))
        if match:
            when = int(match.group(1))
            break

    return Entry(text=text, when=when)


def merge_histories(
    current: list[Entry],
    conflict: list[Entry],
) -> list[Entry]:
    """
    Merge two Fish histories.

    The histories are assumed to be ordered chronologically.

    First, preserve their common prefix. Then merge the two divergent
    suffixes using two pointers ordered by timestamp.

    We intentionally do not globally deduplicate entries: running the
    same command twice is supposed to produce two history entries.
    """

    # Find common prefix.
    common = 0

    while (
        common < len(current)
        and common < len(conflict)
        and current[common].text == conflict[common].text
    ):
        common += 1

    result = current[:common]

    left = current[common:]
    right = conflict[common:]

    i = 0
    j = 0

    while i < len(left) and j < len(right):
        if left[i].when <= right[j].when:
            result.append(left[i])
            i += 1
        else:
            result.append(right[j])
            j += 1

    result.extend(left[i:])
    result.extend(right[j:])

    return result


def write_atomic(path: Path, entries: list[Entry]) -> None:
    """Atomically replace the history file."""

    fd, tmp_name = tempfile.mkstemp(
        prefix=f".{path.name}.",
        dir=path.parent,
    )

    tmp_path = Path(tmp_name)

    try:
        with os.fdopen(fd, "w", encoding="utf-8", newline="") as f:
            for entry in entries:
                f.write(entry.text)

            f.flush()
            os.fsync(f.fileno())

        # Preserve permissions from the existing history file.
        if path.exists():
            shutil.copymode(path, tmp_path)

        os.replace(tmp_path, path)

    except Exception:
        tmp_path.unlink(missing_ok=True)
        raise


def backup(path: Path) -> Path | None:
    """Create a backup of the current history."""

    if not path.exists():
        return None

    backup_path = path.with_name(
        f"{path.name}.backup"
    )

    shutil.copy2(path, backup_path)

    return backup_path


def find_conflicts() -> list[Path]:
    """Find Syncthing conflict files for fish_history."""

    if not HISTORY_DIR.exists():
        return []

    return sorted(
        path
        for path in HISTORY_DIR.iterdir()
        if path.is_file() and CONFLICT_RE.match(path.name)
    )


def merge_conflict(conflict: Path) -> None:
    current = parse_history(HISTORY_FILE)
    other = parse_history(conflict)

    print(f"Merging:")
    print(f"  current:  {HISTORY_FILE}")
    print(f"  conflict: {conflict}")
    print(f"  current entries:  {len(current)}")
    print(f"  conflict entries: {len(other)}")

    merged = merge_histories(current, other)

    print(f"  merged entries:   {len(merged)}")

    backup_path = backup(HISTORY_FILE)

    if backup_path:
        print(f"  backup: {backup_path}")

    write_atomic(HISTORY_FILE, merged)

    # Only remove the conflict after the merged history was successfully
    # written.
    conflict.unlink()

    print("  done")


def main() -> int:
    HISTORY_DIR.mkdir(parents=True, exist_ok=True)

    # Prevent concurrent watchexec instances from modifying the history
    # simultaneously.
    lock_path = HISTORY_DIR / ".fish-history-merge.lock"

    with lock_path.open("w") as lock:
        try:
            fcntl.flock(lock, fcntl.LOCK_EX | fcntl.LOCK_NB)
        except BlockingIOError:
            return 0

        conflicts = find_conflicts()

        if not conflicts:
            return 0

        for conflict in conflicts:
            merge_conflict(conflict)

    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except KeyboardInterrupt:
        raise SystemExit(130)
    except Exception as e:
        print(f"error: {e}", file=sys.stderr)
        raise SystemExit(1)
