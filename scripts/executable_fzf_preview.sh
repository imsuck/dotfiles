#!/usr/bin/env bash

main() {
  COLUMNS=$FZF_PREVIEW_COLUMNS
  if [[ -d $1 ]]; then
    eza -l --icons --color always --no-time $1
  else
    bat --theme ansi --style 'changes,grid,numbers' -f $1 | \
      tail -n +2 | head -n -1
  fi
} 

main $@
