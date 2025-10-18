set -a
[[ -d "${HOME}/.config/environment.d" ]] && source "${HOME}/.config/environment.d/"*".conf"
set +a
