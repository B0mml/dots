# Yet Another Dotfile Repo

OS: CachyOS / Arch Linux

## Programs

- Terminal: ghostty
- Shell: fish
- Editor: Neovim / Doom Emacs
- Desktop: KDE Plasma (Catppuccin theme)

## Quick New Laptop Restore Guide

### 1. Reinstall Packages
```bash
# Official packages
sudo pacman -S --needed - < pkglist-native.txt

# AUR packages (using paru or yay)
paru -S --needed - < pkglist-aur.txt
# or: yay -S --needed - < pkglist-aur.txt
```

### 2. Restore Dotfiles (GNU Stow)
```bash
# Clone repo
git clone git@github.com:B0mml/dots.git ~/dots
cd ~/dots

# Stow configurations
stow fish ghostty nvim tmux doom scripts
```

### 3. Restore Desktop Experience (KDE & Wallpaper)
```bash
# Install konsave
paru -S konsave

# Import & apply desktop profile (from ~/Sync or backup)
konsave -i ~/Sync/my_desktop_theme.knsv  # or path to .knsv file
konsave -a my_desktop_theme
```

### 4. Post-Setup Notes
- **Tmux plugins**: Open tmux and press `Prefix + I` to install plugins.
- **Atuin**: Run `atuin login` to restore shell history.
- **Wallpapers**: Copy `~/Pictures` or sync via Syncthing.

