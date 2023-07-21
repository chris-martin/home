{ pkgs, nixpkgs, ... }:
{
  imports = [ ./git.nix ./nix.nix ./oseary.nix ];

  programs.fish = {
    enable = true;
    package = nixpkgs.from.stable.fish;
    interactiveShellInit = ''
      set fish_greeting
      set --export EDITOR vim
    '';
    shellInit = ''
      set fish_user_paths /home/chris/bin /home/chris/.cabal/bin /home/chris/.local/bin /home/chris/.nix-profile/bin
    '';
    shellAbbrs = {
      restart = "sudo systemctl restart";
      start = "sudo systemctl start";
      stop = "sudo systemctl stop";
      trash = "gio trash";
      clip = "xclip -selection clipboard";
    };
    shellAliases = {
      ls = "ls --color --group-directories-first";
      alert = "${pkgs.xmppc}/bin/xmppc -m message chat chris-mobile@xmpp.typeclasses.com";
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
