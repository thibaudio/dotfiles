set shell := ["bash", "-c"]

stow:
  stow --verbose --target=$HOME --restow */

force-stow:
  stow --verbose --target=$HOME --adopt */
  git reset --hard

unstow:
  stow --verbose --target=$HOME --delete */

install-hyprland:
  sudo pacman -S --needed --noconfirm hyprland hyprlock hypridle swaync waybar kwallet kwallet-pam ksshaskpass blueman xdg-desktop-portal-hyprland xdg-desktop-portal-gtk hyprpolkitagent qt5-wayland qt6-wayland cliphist wl-clip-persist qt6ct kvantum
  systemctl --user enable --now hyprpolkitagent.service

install-tools:
  sudo pacman -S --needed --noconfirm zsh tmux neovim ripgrep fzf fd starship lazygit

install-theme:
  [[ -d "${HOME}/.config/tmux/plugins/catppuccin" ]] || (mkdir -p ${HOME}/.config/tmux/plugins/catppuccin && git clone -b v2.1.3 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux)
  [[ -d "${HOME}/.config/kvantum/catppuccin" ]] || (mkdir -p ${HOME}/.config/kvantum/catppuccin && git clone https://github.com/catppuccin/kvantum.git ${HOME}/.config/kvantum/catppuccin)

install-all: install-hyprland install-tools install-theme

update:
  paru -Syu
  flatpak update

