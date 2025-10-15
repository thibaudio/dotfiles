stow:
  stow --verbose --target=$HOME --restow */
unstow:
  stow --verbose --target=$HOME --delete */

install:
  sudo pacman -S zsh tmux neovim ripgrep fzf fd starship
  git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
