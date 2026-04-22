#!/usr/bin/env bash

main() {
  COLUMNS=$FZF_PREVIEW_COLUMNS
  TARGET=$(printf "$1" | sed "s/^'//;s/'$//")
  if [[ -d $TARGET ]]; then
    eza -l --icons --color always --no-time "$TARGET"
  else
    bat --theme ansi --style 'changes,grid,numbers' -f "$TARGET" | \
      tail -n +2 | head -n -1
  fi
} 

main "$@"
