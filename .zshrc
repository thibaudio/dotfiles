# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

autoload -Uz compinit
compinit

[ -f ~/.specific ] && source ~/.specific

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export EDITOR=nvim
alias nvim="CC=/usr/local/bin/gcc-11 nvim"
alias vim="CC=/usr/local/bin/gcc-11 nvim"
alias vi="CC=/usr/local/bin/gcc-11 nvim"

# kubectl completion
source <(kubectl completion zsh)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# usefull functions
compdefas () {
  if (($+_comps[$1])); then
    compdef $_comps[$1] ${^@[2,-1]}=$1
  fi
}

gch() {
 git checkout "$(git branch --all|fzf|tr -d '[:space:]')"
}

function tssh () {
  if [[ -z "$1" ]]; then
    me="${FUNCNAME[0]}${funcstack[1]}"
    echo "usage: $me [ssh-args] hostname"
    return 1
  fi

  ssh "$@" -t 'tmux attach -t tbs || tmux new -s tbs'
}
compdefas ssh tssh

function sf() {
  rg "$@" ~/Nextcloud/org
}

function ff() {
  if [ -z "$@" ]; then
      output=$(cd "$HOME/Nextcloud/org" && fzf --print-query)
  else
      output=$(cd "$HOME/Nextcloud/org" && fzf -q "$@" --print-query)
  fi
  { read query ; read file } <<< "$output"
  file="$HOME/Nextcloud/org/$file"
  [ -f "$file" ] && nvim "$file" || nvim "${query}-$(date +%d.%m.%y-%H:%M:%S).md"
}

function i() {
  echo "- [ ] $@" >> ~/Nextcloud/todo.md
}

# Python Dev
export WORKON_HOME=~/.pyenv/versions

export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/sqlite/bin:$PATH"

# DOOM
export PATH=~/.emacs.d/bin:$PATH

# pyenv - keep it at the end!
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source ~/powerlevel10k/powerlevel10k.zsh-theme
