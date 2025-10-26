#!/usr/bin/env bash

BASE_DIR=$(pwd)
SCRIPT_PATH="$(realpath "$0")"

find "$BASE_DIR" -type f ! -path "$SCRIPT_PATH" ! -path "README.md" | while read -r FILE; do
    REL_PATH="${FILE#$BASE_DIR/}"
    DEST_PATH="$HOME/$REL_PATH"
    mkdir -p "$(dirname "$DEST_PATH")"
    ln -sf "$FILE" "$DEST_PATH"
    echo "Linked: $DEST_PATH to $FILE"
done
