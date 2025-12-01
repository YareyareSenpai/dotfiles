#!/usr/bin/env bash
set -e

REPO="$HOME/dotfiles"
LOGFILE="$HOME/dotfiles-overlay.log"

echo "==> Starting overlay migration at $(date)" | tee -a "$LOGFILE"

# Helper: move existing folder into repo, then symlink back
migrate() {
    SRC="$HOME/$1"
    DEST="$REPO/$1"

    if [ -L "$SRC" ]; then
        echo "Skipping $SRC (already a symlink)" | tee -a "$LOGFILE"
        return
    fi

    if [ -e "$SRC" ]; then
        mkdir -p "$(dirname "$DEST")"
        mv "$SRC" "$DEST"
        ln -s "$DEST" "$SRC"
        echo "Migrated $SRC -> $DEST (symlinked back)" | tee -a "$LOGFILE"
    else
        echo "Skipping $SRC (not found)" | tee -a "$LOGFILE"
    fi
}

### Curated ~/.config directories
for dir in hypr waybar rofi kitty zsh starship dunst cava btop fastfetch unifetch scripts gtk-3.0 gtk-4.0 Kvantum mpd ncmpcpp mpv systemd; do
    migrate ".config/$dir"
done

### Curated ~/.local/share directories
for dir in applications backgrounds easyeffects fastfetch fonts hyde hyprland icons mpd mybash nvim nwg-look rofi sddm sounds themes waybar; do
    migrate ".local/share/$dir"
done

### User scripts (~/.local/bin)
migrate ".local/bin"

### Home-level additions
migrate ".oh-my-zsh"

### Sensitive configs (only configs, not keys)
mkdir -p "$REPO/.ssh" "$REPO/.gnupg"
if [ -f "$HOME/.ssh/config" ]; then
    mv "$HOME/.ssh/config" "$REPO/.ssh/config"
    ln -s "$REPO/.ssh/config" "$HOME/.ssh/config"
    echo "Migrated .ssh/config" | tee -a "$LOGFILE"
fi
if [ -f "$HOME/.gnupg/gpg.conf" ]; then
    mv "$HOME/.gnupg/gpg.conf" "$REPO/.gnupg/gpg.conf"
    ln -s "$REPO/.gnupg/gpg.conf" "$HOME/.gnupg/gpg.conf"
    echo "Migrated .gnupg/gpg.conf" | tee -a "$LOGFILE"
fi

echo "==> Overlay migration finished at $(date)" | tee -a "$LOGFILE"
notify-send "✅ Dotfiles Overlay" "Home now symlinked to ~/dotfiles"
