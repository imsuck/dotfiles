#!/usr/bin/env bash

org="Wieku"
repo="danser-go"
tag=$(curl "https://api.github.com/repos/$org/$repo/releases/latest" -s | jq .tag_name -r)

wget "https://github.com/$org/$repo/releases/download/$tag/danser-$tag-linux.zip" -O pkg.zip
unzip -o pkg.zip
rm pkg.zip
chmod +x danser danser-cli
