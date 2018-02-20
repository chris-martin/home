set fish_greeting

set -x HOSTNAME (hostname)

set fish_user_paths       \
  $HOME/bin               \
  $HOME/.local/bin        \
  $HOME/.nix-profile/bin  \
  $HOME/.local/share/npm/node_modules/.bin

set -x EDITOR yi
set -x GIT_EDITOR yi

set -x GOPATH ~/go

set -x PYTHONSTARTUP $HOME/.config/python

alias e vim

alias trash gvfs-trash

alias node 'env NODE_NO_READLINE=1 rlwrap node'

alias ls 'ls --color --group-directories-first'

function rip-cd
  abcde -a cddb,read,encode,tag,move,playlist,clean -d /dev/cdrom -o ogg -V
end

function stylish-haskell --argument dir
  cd "$dir"
  and find . -name "*.hs" -not -path '*/\.*' -exec stylish-haskell -i "{}" \;
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

# https://github.com/fish-shell/fish-shell/issues/838
function readSilent # prompt targetVar
    echo -n $argv[1]
    stty -echo
    head -n 1 | read -g $argv[2]
    stty echo
    echo
end

source ~/nix/shell/nix.fish
source ~/.config/fish/bitcoin.fish
source ~/.config/fish/git.fish
source ~/.config/fish/oseary.fish
source ~/.config/fish/prompt.fish
