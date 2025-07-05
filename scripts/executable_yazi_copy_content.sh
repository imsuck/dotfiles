#!/usr/bin/env bash

MIME_TYPE=$(handlr mime $1 --json | jq .[0].mime -r)
if [[ $MIME_TYPE == text* ]]; then
  MIME_TYPE="text/plain"
fi

xclip -t $MIME_TYPE -selection clipboard $1
