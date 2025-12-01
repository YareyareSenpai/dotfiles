#!/usr/bin/env bash
set -e

REPO="$HOME/dotfiles"
LOGFILE="$HOME/dotfiles-install.log"

echo "==> Starting dotfiles install at $(date)" | tee -a "$LOGFILE"

# Helper: create symlink safely
link() {
    SRC="$REPO/$1"
    DEST="$HOME/$2"
    if [ -e "$DEST" ] || [ -L "$DEST" ]; then
        echo "Skipping $DEST (already exists)" | tee -a "$LOGFILE"
    else
        mkdir -p "$(dirname "$DEST")"
        ln -s "$SRC" "$DEST"
        echo "Linked $SRC -> $DEST" | tee -a "$LOGFILE"
    fi
}

### Curated configs (~/.config)
for dir in hypr waybar rofi kitty zsh starship dunst cava btop fastfetch unifetch scripts gtk-3.0 gtk-4.0 Kvantum mpd ncmpcpp mpv systemd; do
    link ".config/$dir" ".config/$dir"
done

### Curated assets (~/.local/share)
for dir in applications backgrounds easyeffects fastfetch fonts hyde hyprland icons mpd mybash nvim nwg-look rofi sddm sounds themes waybar; do
    link ".local/share/$dir" ".local/share/$dir"
done

### User scripts (~/.local/bin)
link ".local/bin" ".local/bin"

### Home-level additions
link "home/.oh-my-zsh" ".oh-my-zsh"

### Sensitive configs (only configs, not keys)
link ".ssh/config" ".ssh/config"
link ".gnupg/gpg.conf" ".gnupg/gpg.conf"

echo "==> Dotfiles install finished at $(date)" | tee -a "$LOGFILE"
notify-send "✅ Dotfiles Install" "Symlinks created successfully"
