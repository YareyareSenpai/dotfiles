#!/bin/bash

# List sinks
sinks=$(wpctl status | awk '/Sinks:/,/Sources:/ {print $1, $2}' | grep -E '^[0-9]+')

# Get current default
current=$(wpctl status | grep "Default" | awk '{print $3}')

if [[ "$1" == "cycle" ]]; then
  # Cycle to next sink
  next=$(echo "$sinks" | awk -v cur="$current" '
    {ids[NR]=$1}
    END {
      for (i=1; i<=NR; i++) if (ids[i]==cur) {
        print ids[(i%NR)+1]
        exit
      }
    }')
  wpctl set-default "$next"
fi

# Print current sink name for Waybar
wpctl status | grep "Default" | awk '{print $3}'
