#!/bin/bash
# cleanup-toggle.sh — auto clear space when blocks are full

# Threshold in MB (adjust as needed)
THRESHOLD=500

# Check free space on root
FREE=$(df -m / | awk 'NR==2 {print $4}')

notify() {
    # Replace with your Waybar/Hyprland toast command
    notify-send "Cleanup" "$1"
}

if [ "$FREE" -lt "$THRESHOLD" ]; then
    notify "Low space detected ($FREE MB). Running cleanup…"

    # 1. Clear pacman cache
    sudo pacman -Scc --noconfirm

    # 2. Remove orphaned packages
    sudo pacman -Rns $(pacman -Qdtq) 2>/dev/null

    # 3. Vacuum journal logs
    sudo journalctl --vacuum-size=100M

    # 4. Clean Flatpak leftovers
    flatpak uninstall --unused -y

    notify "Cleanup complete. Free space: $(df -h / | awk 'NR==2 {print $4}')"
else
    notify "System has enough free space ($FREE MB). No cleanup needed."
fi
