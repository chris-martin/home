set --erase fish_greeting

set -x NIXOS_CONFIG   $HOME/.nix/sys.nix
set -x NIXPKGS_ALL    $HOME/git/nixpkgs

set -x NIX_PATH nixpkgs=$NIXPKGS_ALL:nixos-config=$NIXOS_CONFIG

set PATH                 \
  $HOME/.bin             \
  $HOME/.local/bin       \
  $HOME/.cabal/bin       \
  $HOME/.nix-profile/bin \
  $PATH

set -x ANDROID_HOME $HOME/lib/android

set    EDITOR           emacsclient
set -x ALTERNATE_EDITOR emacs-nw

alias e emacsclient

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
