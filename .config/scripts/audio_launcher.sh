#!/bin/bash
LOG="$HOME/.config/audio_launcher.log"
pkill -f helvum
pkill -f pavucontrol-qt
sleep 0.5

if command -v helvum &>/dev/null; then
  helvum &
  echo "$(date) - Launched helvum" >> "$LOG"
elif command -v pavucontrol-qt &>/dev/null; then
  GDK_BACKEND=x11 pavucontrol-qt &
  echo "$(date) - Launched pavucontrol-qt" >> "$LOG"
else
  notify-send "Audio Launcher" "No GUI audio tool found!"
  echo "$(date) - Failed to launch audio tool" >> "$LOG"
fi
