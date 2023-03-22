{
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
}
