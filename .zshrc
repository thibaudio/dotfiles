autoload -Uz compinit
compinit

[ -f ~/.specific ] && source ~/.specific
source ~/.alias

export GIT_EDITOR=nvim
#alias nvim="CC=/usr/local/bin/gcc-11 nvim"
#alias vim="CC=/usr/local/bin/gcc-11 nvim"
#alias vi="CC=/usr/local/bin/gcc-11 nvim"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
gch() {
 git checkout "$(git branch --all | fzf| tr -d '[:space:]')"
}


bindkey -s ^f "tmux-sessionizer\n"

if [[ -z "$TMUX" ]]; then
    bindkey -s ^a "tmux-attacher\n"
fi

# Python Dev
export WORKON_HOME=~/.pyenv/versions

export PATH="/usr/local/sbin:$PATH"
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



eval "$(starship init zsh)"
