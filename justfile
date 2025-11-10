set shell := ["bash", "-c"]

stow:
  stow --verbose --target=$HOME --restow */

adopt WHAT:
  stow --verbose --target=$HOME --adopt {{ WHAT }}

unstow:
  stow --verbose --target=$HOME --delete */

install-dev:
  sudo pacman -S --needed --noconfirm zsh stow tmux neovim ripgrep fzf fd starship lazygit git-lfs

install-app:
  sudo pacman -S --needed --noconfirm kitty ttf-jetbrains-mono-nerd ksshaskpass wl-clipboard 
