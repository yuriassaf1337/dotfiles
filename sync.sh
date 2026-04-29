#!/bin/bash

DOTS=~/Repositories/dotfiles
CONFIG=~/.config

cp -r "$CONFIG/btop"      "$DOTS/"
cp -r "$CONFIG/fastfetch" "$DOTS/"
cp -r "$CONFIG/hypr"      "$DOTS/"
cp -r "$CONFIG/kitty"     "$DOTS/"
cp    "$CONFIG/mpv/mpv.conf"  "$DOTS/mpv/"
cp    "$CONFIG/mpv/input.conf" "$DOTS/mpv/"
cp    "$CONFIG/mpv/script-opts/"*.conf "$DOTS/mpv/script-opts/"
find  "$CONFIG/mpv/scripts" -maxdepth 1 -type f -name "*.lua" -exec cp {} "$DOTS/mpv/scripts/" \;
cp    "$CONFIG/mpv/fonts/"* "$DOTS/mpv/fonts/"
cp -r "$CONFIG/nvim"      "$DOTS/"
cp -r "$CONFIG/tmux"      "$DOTS/"
cp -r "$CONFIG/walker"    "$DOTS/"
cp -r "$CONFIG/waybar"    "$DOTS/"
cp    "$CONFIG/starship.toml" "$DOTS/"

cp "$CONFIG/omarchy/extensions/menu.sh"              "$DOTS/omarchy/extensions/"
cp "$CONFIG/elephant/menus/omarchy_menu_search.lua"  "$DOTS/elephant/menus/"

echo "dotfiles synced."
