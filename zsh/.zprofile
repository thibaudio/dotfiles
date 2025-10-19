set -a
if [ -d "${HOME}/.config/environment.d" ]; then
  for file in "${HOME}/.config/environment.d/"*".conf"; do
    source $file
  done
fi
set +a
