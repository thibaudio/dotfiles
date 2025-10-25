set shell := ["bash", "-c"]

stow:
  stow --verbose --target=$HOME --restow */

adopt WHAT:
  stow --verbose --target=$HOME --adopt {{ WHAT }}

unstow:
  stow --verbose --target=$HOME --delete */
