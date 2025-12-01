#!/usr/bin/env bash
set -e

REPO="$HOME/dotfiles"
LOGFILE="$HOME/dotfiles-uninstall.log"

echo "==> Starting dotfiles uninstall at $(date)" | tee -a "$LOGFILE"

unlink_safe() {
    DEST="$HOME/$1"
    if [ -L "$DEST" ]; then
        rm "$DEST"
        echo "Removed symlink $DEST" | tee -a "$LOGFILE"
    else
        echo "Skipping $DEST (not a symlink)" | tee -a "$LOGFILE"
    fi
}

### Curated ~/.config directories
for dir in hypr waybar rofi kitty zsh starship dunst cava btop fastfetch unifetch scripts gtk-3.0 gtk-4.0 Kvantum mpd ncmpcpp mpv systemd; do
    unlink_safe ".config/$dir"
done

### Curated ~/.local/share directories
for dir in applications backgrounds easyeffects fastfetch fonts hyde hyprland icons mpd mybash nvim nwg-look rofi sddm sounds themes waybar; do
    unlink_safe ".local/share/$dir"
done

### User scripts (~/.local/bin)
unlink_safe ".local/bin"

### Home-level additions
unlink_safe ".oh-my-zsh"

### Sensitive configs
unlink_safe ".ssh/config"
unlink_safe ".gnupg/gpg.conf"

echo "==> Dotfiles uninstall finished at $(date)" | tee -a "$LOGFILE"
notify-send "🗑️ Dotfiles Uninstall" "Symlinks removed successfully"
