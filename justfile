set shell := ["bash", "-c"]

stow:
  stow --verbose --target=$HOME --restow */

adopt WHAT:
  stow --verbose --target=$HOME --adopt {{ WHAT }}

unstow:
  stow --verbose --target=$HOME --delete */

install-hyprland:
  sudo pacman -S --needed --noconfirm hyprland hyprlock hypridle hyprpaper swaync waybar kwallet kwallet-pam ksshaskpass blueman xdg-desktop-portal-hyprland xdg-desktop-portal-gtk hyprpolkitagent qt5-wayland qt6-wayland cliphist wl-clip-persist qt6ct kvantum ttf-jetbrains-mono-nerd qt6-svg qt6-declarative qt5-quickcontrols2
  sudo paru -S --needed --noconfirm syncthingtray-qt6
  systemctl --user enable --now hyprpolkitagent.service

install-tools:
  sudo pacman -S --needed --noconfirm zsh tmux neovim ripgrep fzf fd starship lazygit

install-theme:
  [[ -d "${HOME}/.config/tmux/plugins/catppuccin" ]] || (mkdir -p ${HOME}/.config/tmux/plugins/catppuccin && git clone -b v2.1.3 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux)
  [[ -d "${HOME}/.config/kvantum/catppuccin" ]] || (mkdir -p ${HOME}/.config/kvantum/catppuccin && git clone https://github.com/catppuccin/kvantum.git ${HOME}/.config/kvantum/catppuccin)

  [[ -d "/usr/share/sddm/themes/catppuccin-mocha-lavender" ]] || just install-sddm-theme

install-all: install-hyprland install-tools install-theme

update:
  paru -Syu
  flatpak update

_install-sddm-theme:
  mkdir -p /tmp/sddm-mocha
  curl -L https://github.com/catppuccin/sddm/releases/download/v1.1.2/catppuccin-mocha-lavender-sddm.zip -o /tmp/sddm-mocha/mocha.zip
  unzip /tmp/sddm-mocha/mocha.zip -d /tmp/sddm-mocha/

  sudo cp sddm.conf /etc/sddm.conf

  sudo mkdir -p /usr/share/sddm/themes
  sudo mv /tmp/sddm-mocha/catppuccin-mocha-lavender /usr/share/sddm/themes/

  rm -rf /tmp/sddm-mocha

