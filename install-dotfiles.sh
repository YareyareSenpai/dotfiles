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

### Core HyDE
link "HyDE" ".config/hyde"

### System configs
link "system/etc" ".etc"
link "system/services" ".config/systemd/user"

### User configs (~/.config)
for dir in btop cava dunst fastfetch hypr kitty Kvantum mpd mpv ncmpcpp nwg-look rofi scripts starship systemd unifetch vim waybar wlogout xsettingsd yay zsh; do
    link "user/.config/$dir" ".config/$dir"
done

### User assets (~/.local/share)
for dir in applications backgrounds easyeffects fastfetch fonts hyde hyprland icons mpd mybash nvim nwg-look rofi sddm sounds themes waybar zed; do
    link "user/.local/share/$dir" ".local/share/$dir"
done

### Home-level additions
link ".icons" ".icons"
link ".themes" ".themes"
link "bin" "bin"
link "Libnick" "Libnick"
link "opera-ffmpeg-solver" "opera-ffmpeg-solver"
link "fix-opera-linux-ffmpeg-widevine" "fix-opera-linux-ffmpeg-widevine"
link "spotify-mpd" "spotify-mpd"
link "Cyberpunk-GRUB-Theme" "Cyberpunk-GRUB-Theme"
link "yay" "yay"
link "zed-preview" "zed-preview"

### Sensitive configs (only configs, not keys)
link ".ssh/config" ".ssh/config"
link ".gnupg/gpg.conf" ".gnupg/gpg.conf"

echo "==> Dotfiles install finished at $(date)" | tee -a "$LOGFILE"
notify-send "✅ Dotfiles Install" "Symlinks created successfully"
