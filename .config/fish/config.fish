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

set fish_user_paths       \
  $HOME/bin               \
  $HOME/.local/bin        \
  $HOME/.nix-profile/bin  \
  $HOME/.local/share/npm/node_modules/.bin

set -x EDITOR e

. $HOME/nix/shell/nix.fish

alias node 'env NODE_NO_READLINE=1 rlwrap node'

function oseary-mount
  env USER=chris PASSWORD=(cat ~/secrets/oseary) HOST=192.168.0.100 MOUNT=$HOME/mnt/oseary sshfs-mount
end

function oseary-umount
  fusermount -u $HOME/mnt/oseary
end

function alias2 --argument alias command
  alias "$alias" "$command"

  # Set tab completion for the alias that works like the full command
  # https://github.com/fish-shell/fish-shell/issues/393#issuecomment-12689588
  complete -c $alias -a "(
    set -l cmd (commandline -op);
    set -e cmd[1];
    complete -C\"$command \$cmd\";
  )"
end

# https://twitter.com/chris__martin/status/420992421673988096
alias2 such git
alias2 very git
alias2 wow st

alias2 add    'git add'
alias2 amend  'git commit --amend'
alias2 staged 'git diff --cached'
alias2 cherry 'git cherry-pick'
alias2 ci     'git commit'
alias2 clone  'git clone'
alias2 co     'git checkout'
alias2 gdiff  'git diff'
alias2 fetch  'git fetch'
alias2 log    'git log'
alias2 merge  'git merge'
alias2 pull   'git pull'
alias2 push   'git push'
alias2 rebase 'git rebase'
alias2 revert 'git revert'
alias2 show   'git show'
alias2 stash  'git stash'

# https://github.com/fish-shell/fish-shell/issues/838
function readSilent # prompt targetVar
    echo -n $argv[1]
    stty -echo
    head -n 1 | read -g $argv[2]
    stty echo
    echo
end
