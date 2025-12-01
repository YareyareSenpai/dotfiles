#!/usr/bin/env bash
set -e

REPO="$HOME/dotfiles"
LOGFILE="$HOME/dotfiles-bootstrap.log"

echo "==> Starting bootstrap at $(date)" | tee -a "$LOGFILE"

# Step 1: Install symlinks for curated configs
"$REPO/install-dotfiles.sh"

# Step 2: Migrate existing configs into repo and symlink back
"$REPO/install-dotfiles-overlay.sh"

echo "==> Bootstrap finished at $(date)" | tee -a "$LOGFILE"
notify-send "🚀 Dotfiles Bootstrap" "Environment deployed successfully"
