#!/usr/bin/env bash

set -e

cd "$(dirname "$0")"

INSTALLTO=${1:-~}

for df in .*; do
  [[ $df = .git ]] || [[ $df = . ]] || [[ $df = .. ]] && continue
  linkto=$(realpath --relative-base="$INSTALLTO" "$df")
  ln -sf "$linkto" "$INSTALLTO/$df"
done
