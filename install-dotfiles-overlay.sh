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

### Core directories
migrate ".config"
migrate ".local/share"
migrate ".icons"
migrate ".themes"
migrate "bin"

### Curated extras
migrate "HyDE"
migrate "Libnick"
migrate "opera-ffmpeg-solver"
migrate "fix-opera-linux-ffmpeg-widevine"
migrate "spotify-mpd"
migrate "Cyberpunk-GRUB-Theme"
migrate "yay"
migrate "zed-preview"

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
