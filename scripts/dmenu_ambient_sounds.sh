#!/bin/sh
set -euo pipefail

soundDir="${HOME}/media/ambient_sounds"
soundFiles=$(/bin/ls -1 "$soundDir" | grep -E ".mp3|.m4a|.ogg")

declare -a options=(
  "Choose sound file"
  "Play random sound"
  "Stop sound player"
  "Quit"
)

declare -a soundList=$soundFiles

choice=$(printf '%s\n' "${options[@]}" | dmenu -i -p 'Ambient sounds:' "${@}")

if [ "$choice" == "Choose sound file" ]; then
  choice=$(printf '%s\n' "${soundList[@]}" | sort | dmenu -i -l 20 -p 'Choose sound file:' "$@")
  kill "$(cat "$HOME/.cache/dmenu_ambient_sounds")" || echo "ffplay was not running."
  ffplay -nodisp -loop 0 "$soundDir/$choice" &
  _pid=$!
  echo "$_pid" > "$HOME/.cache/dmenu_ambient_sounds"

elif [ "$choice" == "Play random sound" ]; then
  getRand=$(printf '%s\n' "${soundList[@]}" | shuf -n 1)
  kill "$(cat "$HOME/.cache/dmenu_ambient_sounds")" || echo "ffplay was not running."
  ffplay -nodisp -loop 0 "$soundDir/$getRand" &
  _pid=$!
  echo "$_pid" > "$HOME/.cache/dmenu_ambient_sounds"

elif [ "$choice" == "Stop sound player" ]; then
  kill "$(cat "$HOME/.cache/dmenu_ambient_sounds")" || echo "ffplay was not running."

else
  echo "Program terminated." && exit 0
fi
