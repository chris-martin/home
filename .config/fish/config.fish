set --erase fish_greeting

set HOSTNAME (hostname)

set PATH                 \
  $HOME/.bin             \
  $HOME/.local/bin       \
  $HOME/.cabal/bin       \
  $HOME/.nix-profile/bin \
  $PATH

function use_emacs
  set -g EDITOR emacsclient
  set -g -x ALTERNATE_EDITOR emacs-nw
end

function use_vim
  set -g EDITOR vim
end

switch (echo $HOSTNAME)
  case annemarie ; use_emacs
  case renzo     ; use_emacs
  case mandeeza  ; use_vim
end

alias e $EDITOR

# https://twitter.com/chris__martin/status/420992421673988096
alias such git
alias very git
alias wow 'git status'

alias add    'git add'
alias amend  'git commit --amend'
alias staged 'git diff --cached'
alias cherry 'git cherry-pick'
alias ci     'git commit'
alias clone  'git clone'
alias co     'git checkout'
alias gdiff  'git diff'
alias fetch  'git fetch'
alias log    'git log'
alias merge  'git merge'
alias pull   'git pull'
alias push   'git push'
alias rebase 'git rebase'
alias show   'git show'
alias stash  'git stash'

# https://github.com/fish-shell/fish-shell/issues/838
function readSilent # prompt targetVar
    echo -n $argv[1]
    stty -echo
    head -n 1 | read -g $argv[2]
    stty echo
    echo
end
