set --erase fish_greeting

set PATH $HOME/bin $HOME/.local/bin $HOME/.cabal/bin $PATH

set -x ANDROID_HOME $HOME/lib/android

set EDITOR vim

alias emacs '/usr/bin/env emacs -nw'

# https://twitter.com/chris__martin/status/420992421673988096
alias such git
alias very git
alias wow 'git status'

# https://github.com/fish-shell/fish-shell/issues/838
function readSilent # prompt targetVar
    echo -n $argv[1]
    stty -echo
    head -n 1 | read -g $argv[2]
    stty echo
    echo
end
