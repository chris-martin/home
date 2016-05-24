set --erase fish_greeting

functions --copy fish_prompt default_fish_prompt

function fish_prompt
  if [ $FISH_PROMPT ]
    echo "$FISH_PROMPT"
  else
    default_fish_prompt
  end
end

set -x HOSTNAME (hostname)

set fish_user_paths      \
  $HOME/bin              \
  $HOME/.local/bin       \
  $HOME/.nix-profile/bin

set -x EDITOR e

. $HOME/nix/shell/nix.fish

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
alias revert 'git revert'
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
