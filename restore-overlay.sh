#!/usr/bin/env bash
set -e

REPO="$HOME/dotfiles"
LOGFILE="$HOME/dotfiles-restore.log"

echo "==> Starting overlay restore at $(date)" | tee -a "$LOGFILE"

restore() {
    SRC="$HOME/$1"
    DEST="$REPO/$1"

    if [ -L "$SRC" ]; then
        rm "$SRC"
        mv "$DEST" "$SRC"
        echo "Restored $SRC from $DEST" | tee -a "$LOGFILE"
    else
        echo "Skipping $SRC (not a symlink)" | tee -a "$LOGFILE"
    fi
}

### Curated ~/.config directories
for dir in hypr waybar rofi kitty zsh starship dunst cava btop fastfetch unifetch scripts gtk-3.0 gtk-4.0 Kvantum mpd ncmpcpp mpv systemd; do
    restore ".config/$dir"
done

### Curated ~/.local/share directories
for dir in applications backgrounds easyeffects fastfetch fonts hyde hyprland icons mpd mybash nvim nwg-look rofi sddm sounds themes waybar; do
    restore ".local/share/$dir"
done

### User scripts (~/.local/bin)
restore ".local/bin"

### Home-level additions
restore ".oh-my-zsh"

### Sensitive configs
restore ".ssh/config"
restore ".gnupg/gpg.conf"

echo "==> Overlay restore finished at $(date)" | tee -a "$LOGFILE"
notify-send "♻️ Dotfiles Restore" "Configs restored to home"
