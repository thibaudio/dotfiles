set shell := ["bash", "-c"]

stow:
  stow --verbose --target=$HOME --restow */

adopt WHAT:
  stow --verbose --target=$HOME --adopt {{ WHAT }}

unstow:
  stow --verbose --target=$HOME --delete */

install:
  sudo pacman -S --needed --noconfirm zsh stow kitty tmux neovim ripgrep fzf fd starship lazygit ttf-jetbrains-mono-nerd ksshaskpass
