{ pkgs, ... }:
{
    imports = [ ./git.nix ./oseary.nix ];

    programs.fish = {
        enable = true;
        interactiveShellInit = ''
            set fish_greeting
            set --export EDITOR vim
        '';
        shellInit = ''
            set fish_user_paths /home/chris/bin /home/chris/.cabal/bin /home/chris/.local/bin /home/chris/.nix-profile/bin
        '';
        shellAbbrs = {
            rebuild = "sudo nixos-rebuild --flake /home/chris/.config/nix/(hostname) switch";

            restart = "sudo systemctl restart";
            start = "sudo systemctl start";
            stop = "sudo systemctl stop";

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
        };
    };
}
