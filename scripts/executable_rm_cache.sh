#!/usr/bin/env bash

if [[ ! -t 0 || ! -t 1 ]]; then
  exec alacritty --class="floater,floater" -e bash "$0"
fi

echo "Running yay -Scc"
sudo rmdir /var/cache/pacman/pkg/download* || true

# Pacman cache
sudo pacman -Scc

# AUR build caches
for cache in ~/.cache/yay ~/.cache/paru; do
  [ -d "$cache" ] || continue

  find "$cache" -mindepth 1 -maxdepth 1 -type d -print0 2>/dev/null |
  while IFS= read -r -d '' repo; do
    name=$(basename "$repo")

    case $name in
      completion.cache|vcs.json)
        continue
        ;;
    esac

    if git -C "$repo" rev-parse --is-inside-work-tree &>/dev/null; then
      echo "cleaning $repo"
      git -C "$repo" clean -fd
    fi
  done
done

read -p "Remove firefox cache? " ff_cache
case $ff_cache in
  [Yy]*)
    for dir in ~/.cache/mozilla/firefox/*; do
      [ -d "$dir/cache2" ] && rm -rf "$dir/cache2"
    done
    ;;
esac

read -rp "Remove Electron/Chromium app caches in ~/.config? " electron_cache
case $electron_cache in
  [Yy]*)
    declare -A seen_apps

    fd -HI -td --prune '^(Cache|Code Cache|GPUCache|ShaderCache|GrShaderCache|DawnCache)$' ~/.config \
    | while IFS= read -r cache_dir; do
        app_dir="$(dirname "$cache_dir")"

        if [[ -z "${seen_apps[$app_dir]}" ]]; then
            echo "$app_dir"
            seen_apps["$app_dir"]=1
        fi

        size=$(du -sh "$cache_dir" 2>/dev/null | cut -f1)
        echo "  removing [$size] $(basename "$cache_dir")"
        rm -rf "$cache_dir"
      done
    ;;
esac
