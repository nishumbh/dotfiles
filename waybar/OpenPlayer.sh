#!/bin/bash

# Get the currently active player
player=$(playerctl -l 2>/dev/null | head -n 1)

if [ -z "$player" ]; then
  notify-send "No active media player found."
  exit 1
fi

# Function to search for window and switch workspace
focus_app() {
  app_class="$1"
  launch_cmd="$2"

  # Get the window address and workspace using hyprctl
  window_info=$(hyprctl clients -j | jq -r \
    --arg app "$app_class" '.[] | select(.class == $app or .initialClass == $app) | "\(.address) \(.workspace.id)"' | head -n 1)

  if [ -n "$window_info" ]; then
    workspace_id=$(echo "$window_info" | awk '{print $2}')
    hyprctl dispatch workspace "$workspace_id"
  else
    exec $launch_cmd &
  fi
}

case "$player" in
spotify)
  focus_app "Spotify" "spotify"
  ;;
vlc)
  focus_app "Vlc" "vlc"
  ;;
mpv)
  focus_app "mpv" "mpv"
  ;;
firefox | chromium | brave | google-chrome)
  notify-send "$player is likely playing media via the browser. Switch manually."
  ;;
*)
  notify-send "No workspace mapping for player: $player"
  ;;
esac
