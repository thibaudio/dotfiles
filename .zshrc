autoload -Uz compinit
compinit

[ -f ~/.specific ] && source ~/.specific
source ~/.alias

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export GIT_EDITOR=nvim
#alias nvim="CC=/usr/local/bin/gcc-11 nvim"
#alias vim="CC=/usr/local/bin/gcc-11 nvim"
#alias vi="CC=/usr/local/bin/gcc-11 nvim"

# kubectl completion
source <(kubectl completion zsh)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

bindkey -s ^f "tmux-sessionizer\n"
bindkey -s ^n "tmux-sessionizer ~/Nextcloud/org\n"

# Python Dev
export WORKON_HOME=~/.pyenv/versions

export PATH="/usr/local/sbin:$PATH"

# pyenv - keep it at the end!
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# use fd instead of find
export FZF_DEFAULT_COMMAND="fd . $HOME"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d . $HOME"

export PYENV_VIRTUALENV_DISABLE_PROMPT=0

export PATH="${HOME}/bin:$PATH"

eval "$(starship init zsh)"
