# Ryan's Dotfiles

A collection of my dotfiles. I aim to maintain compatibility with the latest Ubuntu LTS and macOS
release, though some commands may be only designed to work on one platform or another.

## Setup
```bash
git clone https://github.com/1egoman/dotfiles ~/dotfiles
cd ~/dotfiles
```

## Running the install script
- `./install.sh`: Install all dotfiles. If a dotfile already exists, prompt to replace it.
- `./install.sh --force` (or `./install.sh --yes`): Overwrite all dotfiles, even if they exist
  already.
- `./install.sh --no`: Only append dotfiles that don't already exist.
