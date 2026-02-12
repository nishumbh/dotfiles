#!/bin/bash

# Check if any players are in Playing or Paused state
active_players=$(playerctl -l 2>/dev/null)

is_playing_or_paused=false

for player in $active_players; do
  status=$(playerctl -p "$player" status 2>/dev/null)
  if [[ "$status" == "Playing" || "$status" == "Paused" ]]; then
    is_playing_or_paused=true
    break
  fi
done

if [ "$is_playing_or_paused" = true ]; then
  # Follow metadata updates
  playerctl -a metadata --format '{"text": "{{artist}}:{{markup_escape(title)}}", "tooltip": "{{playerName}}:{{markup_escape(title)}}", "alt": "{{status}}", "class": "{{status}}"}' -F
else
  # Output static "Nothing Playing" message
  echo '{"text": "Nothing Playing", "tooltip": "No active player", "alt": "Stopped", "class": "Stopped"}'
  # Optionally, loop and update when status changes (if needed)
fi
