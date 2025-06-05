#!/usr/bin/env bash

org=""
repo=""

cur_tag=$(touch .tag_cache; cat .tag_cache)
tag=$(curl "https://api.github.com/repos/$org/$repo/releases/latest" -s | jq .tag_name -r)

bin_name=""

echo "Current tag: $cur_tag"
echo "Latest tag: $tag"
if [[ $tag != ${cur_tag:-0} ]]; then
  echo $tag > .tag_cache
  wget -nv --show-progress \
    "https://github.com/$org/$repo/releases/download/$tag/$bin_name" -O "$bin_name"
fi
