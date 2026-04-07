#!/bin/bash
status=$(playerctl status 2>/dev/null)

if [ -z "$status" ] || [ "$status" = "No players found" ]; then
    echo ""
    exit 0
fi

artist=$(playerctl metadata artist 2>/dev/null)
title=$(playerctl metadata title 2>/dev/null)
display="${artist:+$artist - }$title"

max=30
if [ ${#display} -gt $max ]; then
    display="${display:0:$max}…"
fi

if [ "$status" = "Playing" ]; then
    echo "▶  $display"
elif [ "$status" = "Paused" ]; then
    echo "⏸  $display"
fi
