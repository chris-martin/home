paths=(
  "$HOME/bin"
  "$HOME/.local/bin"
  "$HOME/.cabal/bin"
  "$HOME/.nix-profile/bin"
  "$HOME/.local/share/npm/node_modules/.bin"
)

export PATH="$(printf '%s:' "${paths[@]%/}")$PATH"

export EDITOR=e

. $HOME/nix/shell/nix.bash

export PYTHONSTARTUP="$HOME/.config/python"

# https://twitter.com/chris__martin/status/420992421673988096
alias such=git
alias very=git
alias  wow='git status'

alias    add='git add'
alias  amend='git commit --amend'
alias staged='git diff --cached'
alias cherry='git cherry-pick'
alias     ci='git commit'
alias  clone='git clone'
alias     co='git checkout'
alias  gdiff='git diff'
alias  fetch='git fetch'
alias    log='git log'
alias  merge='git merge'
alias   pull='git pull'
alias   push='git push'
alias rebase='git rebase'
alias revert='git revert'
alias   show='git show'
alias  stash='git stash'
