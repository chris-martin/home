{ pkgs, ... }:
{
    programs.git = {
        enable = true;
        userName = "Chris Martin";
        userEmail = "ch.martin@gmail.com";
        extraConfig = {
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
        ignores = [

            # Visual Studio Code
            ".vscode" ".history"

            # Haskell
            ".cabal-sandbox" ".stack-work" "dist-newstyle" "ghcid.txt" "cabal.project.local"

            # Nix
            ".nix-gc-roots"

            # IntelliJ
            "*.ipr" "*.swp" ".idea" "*.iml" "ideaHaskellLib" ".ideaHaskellLib"

            # Vagrant
            ".vagrant"

            # Python
            "*.pyc" "*.egg"

            # Emacs
            ".projectile"

            # Sublime
            "*.sublime-workspace"

            # PID files contain IDs of running processes
            "*.pid"

        ];
    };
}
