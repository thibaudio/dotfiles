autoload -Uz compinit
compinit

[ -f ~/.specific ] && source ~/.specific
source ~/.alias

export GIT_EDITOR=nvim

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

bindkey -v
bindkey '^R' history-incremental-search-backward
bindkey -s ^f "tmux-sessionizer\n"

if [[ -z "$TMUX" ]]; then
    bindkey -s ^a "tmux-attacher\n"
fi

export PATH="${HOME}/.local/bin:$PATH"

# use fd instead of find
export FZF_DEFAULT_COMMAND="fd . $HOME"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d . $HOME"

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)
      eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
      ;;
    Darwin*)    ;;
    CYGWIN*)    ;;
    MINGW*)     ;;
    MSYS_NT*)   ;;
    *)          echo "Unknown Platform: ${unameOut}"
esac

# pnpm
export PNPM_HOME="/home/thibaud/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

eval "$(starship init zsh)"
