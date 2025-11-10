set shell := ["bash", "-c"]

stow:
  stow --verbose --target=$HOME --restow */

adopt WHAT:
  stow --verbose --target=$HOME --adopt {{ WHAT }}

unstow:
  stow --verbose --target=$HOME --delete */

install-dev:
  just _install-dev-{{os()}}

install-app:
  sudo pacman -S --needed --noconfirm kitty ttf-jetbrains-mono-nerd ksshaskpass wl-clipboard 

_install-dev-linux:
  sudo pacman -S --needed --noconfirm zsh stow tmux neovim ripgrep fzf fd starship lazygit git-lfs

_install-dev-windows:
  winget install neovim ripgrep fzf fd starship lazygit
