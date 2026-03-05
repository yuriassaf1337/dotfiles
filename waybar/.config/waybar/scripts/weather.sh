#!/bin/bash

#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────
#  current weather for vitória
#
#  output format:
#    { "text": "🌡 24°C 🌧", "tooltip": "...", "class": "..." }
#
#  config example:
#    "custom/weather": {
#        "exec": "~/.config/waybar/scripts/weather-vitoria.sh",
#        "interval": 600,
#        "return-type": "json"
#    }
# ─────────────────────────────────────────────────────────────

LAT="-20.3222"
LON="-40.3381"

URL="https://api.open-meteo.com/v1/forecast?latitude=${LAT}&longitude=${LON}&current=temperature_2m,precipitation,weathercode&temperature_unit=celsius&timezone=America%2FSao_Paulo"

# ── Loading / buffer state ────────────────────────────────────
LOADING_ICON="󰔟"   # nerd font buffer/spinner

# ── Fetch data ────────────────────────────────────────────────
RESPONSE=$(curl -sf --max-time 8 "$URL")

if [[ -z "$RESPONSE" ]]; then
    printf '{"text": "%s  ---", "tooltip": "weather unavailable", "class": "error"}\n' "$LOADING_ICON"
    exit 0
fi

# ── Parse JSON with jq ────────────────────────────────────────
if ! command -v jq &>/dev/null; then
    printf '{"text": "install jq", "tooltip": "jq is required", "class": "error"}\n'
    exit 1
fi

TEMP=$(echo "$RESPONSE"    | jq -r '.current.temperature_2m')
PRECIP=$(echo "$RESPONSE"  | jq -r '.current.precipitation')
WMO=$(echo "$RESPONSE"     | jq -r '.current.weathercode')

# ── WMO weather code → precipitation/condition emoji ─────────
wmo_to_emoji() {
    local code=$1
    case $code in
        0)            echo "󰖙"  ;;
        1)            echo "󰖕"  ;;
        2)            echo "󰖔"  ;;
        3)            echo "󰖐"  ;;
        45|48)        echo "󰖑"  ;;
        51|53|55)     echo "󰖗"  ;;
        56|57)        echo "󰖖"  ;;
        61|63|65)     echo "󰖖"  ;;
        66|67)        echo "󰖘"  ;;
        71|73|75|77)  echo "󰼶"  ;;
        80|81|82)     echo "󰖓"  ;;
        85|86)        echo "󰖘"  ;;
        95)           echo "󰖓"  ;;
        96|99)        echo "󰖓"  ;;
        *)            echo "󰔏"  ;;
    esac
}

CONDITION_EMOJI=$(wmo_to_emoji "$WMO")

# ── Round temperature to integer ─────────────────────────────
TEMP_INT=$(printf "%.0f" "$TEMP")

# ── Build tooltip ─────────────────────────────────────────────
TOOLTIP="Vitória, ES  |  ${TEMP_INT}°C  ${CONDITION_EMOJI}\nPrecipitation: ${PRECIP} mm"

# ── CSS class for colouring (optional) ───────────────────────
if (( TEMP_INT >= 35 )); then CSS_CLASS="hot"
elif (( TEMP_INT >= 28 )); then CSS_CLASS="warm"
elif (( TEMP_INT >= 20 )); then CSS_CLASS="mild"
else CSS_CLASS="cool"
fi

# ── Emit JSON for Waybar ──────────────────────────────────────
printf '{"text": " %d°C %s", "tooltip": "%s", "class": "%s"}\n' \
    "$TEMP_INT" \
    "$CONDITION_EMOJI" \
    "$TOOLTIP" \
    "$CSS_CLASS"
