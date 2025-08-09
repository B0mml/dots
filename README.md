# Yet Another Dotfile Repo

OS: CachyOS

## Programs

- Terminal: ghostty
- Shell: fish
- Editor: Neovim

## Installation

### Prerequisites

```bash
# Install GNU Stow
sudo pacman -S stow  # Arch/CachyOS

sudo apt install stow  # Ubuntu/Debian

brew install stow  # macOS
```

### Setup

```bash
# Clone this repository
git clone https://github.com/yourusername/dotfiles.git ~/Dotfiles
cd ~/Dotfiles

# Install all configurations
stow */

# Or install individual programs eg.
stow fish # or
stow nvim
```

### Uninstall

```bash
cd ~/Dotfiles

# Remove all symlinks
stow -D */

# Or remove individual programs
stow -D fish
stow -D nvim
# etc.
```

## Additional Requirements
<https://github.com/illiteratewriter/todoist-rs>
<https://github.com/sachaos/todoist>
<https://atuin.sh/>
<https://github.com/MordechaiHadad/bob>

## Notes

- After installing tmux config, press `Prefix + I` to install plugins
