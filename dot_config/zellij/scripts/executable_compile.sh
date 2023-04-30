#!/usr/bin/env sh

DIR="$(dirname "$0")"

echo "---------- Compilation ---------"
g++ -std=c++11 -O2 -Wall -o a.out $(fd -ae cpp --changed-within 3s)

bash -c "$DIR/test.sh"
