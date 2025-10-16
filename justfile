set shell := ["bash", "-c"]

stow:
  stow --verbose --target=$HOME --restow */
unstow:
  stow --verbose --target=$HOME --delete */

install-hyprland:
  sudo pacman -S --needed --noconfirm hyprland hyprlock hypridle swaync

install-tools:
  sudo pacman -S --needed --noconfirm zsh tmux neovim ripgrep fzf fd starship lazygit

install-theme:
  [[ -d "${HOME}/.config/tmux/plugins/catppuccin" ]] || (mkdir -p ${HOME}/.config/tmux/plugins/catppuccin && git clone -b v2.1.3 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux)

install-all: install-hyprland install-tools install-theme
