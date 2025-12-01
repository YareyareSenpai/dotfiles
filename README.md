# 🗂️ Dotfiles Overlay

A lean, reproducible dotfiles setup for Linux/Hyprland, with lifecycle scripts to install, migrate, restore, and uninstall configs. Everything is curated for clarity, portability, and theme‑aware workflows.

---

## 📦 Structure

- `.config/` → curated configs (Hyprland, Waybar, Rofi, Kitty, Zsh, Starship, etc.)
- `.local/share/` → fonts, icons, themes, backgrounds, sounds, app configs
- `.local/bin/` → custom scripts
- `home/` → additions like `.oh-my-zsh/`
- `bin/` → helper binaries
- `README.md` → documentation
- `bootstrap.sh` → one‑liner setup

---

## 🛠 Lifecycle Scripts

| Script                     | Purpose                                                                 |
|-----------------------------|-------------------------------------------------------------------------|
| `bootstrap.sh`              | One‑liner setup: installs symlinks and migrates configs into the repo   |
| `install-dotfiles.sh`       | Symlinks curated configs from repo into `$HOME`                         |
| `install-dotfiles-overlay.sh` | Migrates existing configs into repo and symlinks them back             |
| `restore-overlay.sh`        | Restores configs from repo into `$HOME` (reverse overlay)               |
| `uninstall-dotfiles.sh`     | Removes symlinks without touching actual files                          |

Run from the repo root (`~/dotfiles`) to manage your environment cleanly and reproducibly.

---

## 🚀 Usage

```bash
# Bootstrap a fresh system
./bootstrap.sh

# Install curated configs
./install-dotfiles.sh

# Overlay existing configs into repo
./install-dotfiles-overlay.sh

# Restore configs from repo
./restore-overlay.sh

# Uninstall symlinks
./uninstall-dotfiles.sh
