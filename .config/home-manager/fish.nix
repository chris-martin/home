{
    programs.fish = {
        enable = true;
        interactiveShellInit = ''
            set fish_greeting

            set --export EDITOR vim
            set --export GIT_EDITOR vim

            complete -f -c oseary -a mount -n __fish_oseary_needs_command -d "Mount the NAS"
            complete -f -c oseary -a umount -n __fish_oseary_needs_command -d "Unmount the NAS"
        '';
        shellInit = ''
            set fish_user_paths /home/chris/bin /home/chris/.cabal/bin /home/chris/.local/bin /home/chris/.nix-profile/bin
            set --export HOSTNAME (hostname)
            set --export NIX_PATH "/home/chris/.config/nix-path"
            set --export NIXOS_CONFIG "/home/chris/.config/nixos/config.nix"
            set --export NIXPKGS_CONFIG "/home/chris/.config/nixpkgs/config.nix"
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
}
