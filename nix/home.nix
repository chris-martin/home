{ pkgs, ... }:
let

pkgsUnstable = import <nixpkgs-unstable> {};

in
{

nixpkgs.config = import /home/chris/nix/config.nix;

home.stateVersion = "22.11";

programs.firefox.enable = true;

programs.fish = {
    enable = true;
    shellInit = ''
        set fish_greeting
        set fish_user_paths $HOME/bin $HOME/.cabal/bin $HOME/.local/bin $HOME/.nix-profile/bin

        set --export EDITOR vim
        set --export GIT_EDITOR vim
        set --export HOSTNAME (hostname)
        set --export NIX_PATH "$HOME/nix/path"
        set --export NIXOS_CONFIG "$HOME/nix/os/config.nix"
        set --export NIXPKGS_CONFIG "$HOME/nix/config.nix"

        complete -f -c oseary -a mount -n __fish_oseary_needs_command -d "Mount the NAS"
        complete -f -c oseary -a umount -n __fish_oseary_needs_command -d "Unmount the NAS"
    '';
    shellAbbrs = {
        add = "git add";
        amend = "git commit --amend";
        staged = "git diff --cached";
        cherry = "git cherry-pick";
        ci = "git commit";
        clone = "git clone";
        co = "git checkout";
        fetch = "git fetch";
        log = "git log";
        merge = "git merge";
        pull = "git pull";
        push = "git push";
        rebase = "git rebase";
        revert = "git revert";
        show = "git show";
        stash = "git stash";
    };
    shellAliases = {
        clip = "xclip -selection clipboard";
        ls = "ls --color --group-directories-first";
        trash = "gio trash";
    };
    functions = {
        # Set tab completion for the alias that works like the full command
        # https://github.com/fish-shell/fish-shell/issues/393#issuecomment-12689588
        alias2 = {
            argumentNames = "alias command";
            body = ''
                alias "$alias" "$command"
                complete -c $alias -a "(
                  set -l cmd (commandline -op);
                  set -e cmd[1];
                  complete -C\"$command \$cmd\";
                )"
            '';
        };
        hsnix = {
            argumentNames = "pkg";
            body = ''
                cabal2nix "cabal://$pkg" > "$pkg.nix"
            '';
        };
        oseary = {
            argumentNames = "command";
            body = ''
                switch $command

                case mount
                  mkdir -p $HOME/.oseary
                  env USER=chris PASSWORD=(cat ~/secrets/oseary) \
                    HOST=192.168.0.100 MOUNT=$HOME/.oseary sshfs-mount

                case umount
                  fusermount -z -u $HOME/.oseary; and echo "Unmounting"
                  sleep 1
                  rmdir $HOME/.oseary

                case '*'
                  echo "???"

                end
            '';
        };
        __fish_oseary_needs_command = {
            body = ''
                set cmd (commandline -opc)
                if [ (count $cmd) -eq 1 ]
                  return 0
                else
                  return 1
                end
            '';
        };
    };
};

programs.git = {
    enable = true;
    userName = "Chris Martin";
    userEmail = "ch.martin@gmail.com";
    extraConfig = {
        core.excludesfile = "~/.config/git/ignore";
        pager.log = "less -c -+F";
        diff.tool = "vimdiff";
        diff.guitool = "meld";
        color.diff = "auto";
        color.status = "auto";
        color.branch = "auto";
        color.ui = "auto";
        color.interactive = "auto";
        alias = {
            st = "!bash -c 'if [[ $(which st) ]]; then st; else git status; fi'";
            co = "checkout";
            ci = "commit";
            br = "!bash -c br";
            top = "!git log --format=format:%an | sort | uniq -c | sort -rg | head -n 20";
            graph = "!f() { git log --oneline --abbrev-commit --graph --decorate; }; f";
            file-log = "!git log --diff-filter=AD --summary";
        };
        log.date = "local";
        format.pretty = "%C(yellow)%h%Creset%Cblue%d%Creset %Cgreen%an%Creset %Cred%cr%Creset %C(magenta)(%ci)%Creset%n%B";
        merge.tool = "vimdiff";
        push.default = "tracking";
        pull.rebase = "false";
        init.defaultBranch = "master";
    };
};

programs.home-manager.enable = true;

programs.vim = {
    enable = true;
    settings = {
        ignorecase = true;
        smartcase = true;
        shiftwidth = 2;
        tabstop = 2;
    };
    extraConfig = ''
        set lbr

        " Rename : to ; so you can type it more easily without shift
        nnoremap ; :

        " Aliases for common typos
        command Wq wq
        command WQ wq
        command Q q

        function! s:Saving_scroll(cmd)
            let save_scroll = &scroll
            execute 'normal! ' . a:cmd
            let &scroll = save_scroll
        endfunction
        nnoremap <C-J> :call <SID>Saving_scroll("1<C-V><C-D>")<CR>
        vnoremap <C-J> <Esc>:call <SID>Saving_scroll("gv1<C-V><C-D>")<CR>
        nnoremap <C-K> :call <SID>Saving_scroll("1<C-V><C-U>")<CR>
        vnoremap <C-K> <Esc>:call <SID>Saving_scroll("gv1<C-V><C-U>")<CR>

        " enable syntax highlighting
        syntax on

        " insert spaces instead of tabs
        set expandtab

        " enable automatic indentation
        set autoindent

        set backspace=indent,eol,start

        " keystrokes which may wrap around lines:
        "   b          backspace
        "   s          space
        "   <,>,h,l    arrow keys
        "   [,]        arrow keys in insert mode
        set whichwrap=b,s,<,>,h,l,[,]

        " when truncating the last line in a window, display @
        " symbols at the end of the line, instead of one per line
        set display=lastline

        " show line numbers
        set number

        " turn on search highlighting
        set hls

        " save (^\ exits visual mode)
        inoremap <F12> <Space><BS><C-\><C-O>:update<CR>

        set incsearch

        filetype on

        filetype plugin on

        set ttymouse=xterm2
    '';
};

programs.vscode = {
    enable = true;
    extensions = [
        pkgs.vscode-extensions.bbenoist.nix
        pkgs.vscode-extensions.haskell.haskell
        pkgs.vscode-extensions.james-yu.latex-workshop
        pkgs.vscode-extensions.skyapps.fish-vscode
        pkgs.vscode-extensions.slevesque.vscode-multiclip
        pkgs.vscode-extensions.stkb.rewrap
    ];
};

home.packages = [
    pkgs.baobab
    pkgsUnstable.cabal2nix
    pkgs.cachix
    pkgs.curl
    pkgs.cryptsetup
    pkgs.eog
    pkgs.evince
    pkgs.file-roller
    pkgs.meld
    pkgs.xclip
];

}
