#!/bin/bash

DOTS=~/Repositories/dotfiles
CONFIG=~/.config

cp -r "$CONFIG/btop"      "$DOTS/"
cp -r "$CONFIG/fastfetch" "$DOTS/"
cp -r "$CONFIG/hypr"      "$DOTS/"
cp -r "$CONFIG/kitty"     "$DOTS/"
cp -r "$CONFIG/nvim"      "$DOTS/"
cp -r "$CONFIG/tmux"      "$DOTS/"
cp -r "$CONFIG/walker"    "$DOTS/"
cp -r "$CONFIG/waybar"    "$DOTS/"
cp    "$CONFIG/starship.toml" "$DOTS/"

echo "dotfiles synced."
