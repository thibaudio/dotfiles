# dotfiles
My dotfiles for archlinux / Windows / WSL

## Require
- [just](https://github.com/casey/just)
- git

## Usage
```sh
just install-dev      # install cli packages
just install-app      # install linux apps
just stow             # link dotfiles
just unstow           # unlink dotfiles
just adopt <target>   # adopt a new file
```

## Notes
### Windows
Windows support is limited to nvim config
- Run `just install-dev`
- Add 7zip to your PATH
- Start nvim
If mason failed to install tree-sitter-cli, start nvim from bash once.

### WSL
`just install-dev` only supports archlinux  
Don't run `just install-app`
