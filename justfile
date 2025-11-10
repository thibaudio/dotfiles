set shell := ["bash", "-c"]
set windows-shell := ["powershell.exe", "-c"]

stow:
  just _stow-{{os()}}

_stow-linux:
  stow --verbose --target=$HOME --restow */

_stow-windows:
  Start-Process powershell.exe -Verb runAs -ArgumentList "New-Item -Path $env:LOCALAPPDATA\nvim -ItemType SymbolicLink -Value {{justfile_directory()}}\nvim\.config\nvim -Force"

adopt WHAT:
  stow --verbose --target=$HOME --adopt {{ WHAT }}

unstow:
  just _unstow-{{os()}}

_unstow-linux:
  stow --verbose --target=$HOME --delete */

_unstow-windows:
  Start-Process powershell.exe -Verb runAs -ArgumentList "Remove-Item -Path $env:LOCALAPPDATA\nvim"

install-app:
  sudo pacman -S --needed --noconfirm kitty ttf-jetbrains-mono-nerd ksshaskpass wl-clipboard 

install-dev:
  just _install-dev-{{os()}}

_install-dev-linux:
  sudo pacman -S --needed --noconfirm zsh stow tmux neovim ripgrep fzf fd starship lazygit git-lfs

_install-dev-windows:
  winget install neovim ripgrep fzf fd lazygit
