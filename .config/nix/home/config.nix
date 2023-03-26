{ pkgs, config, ... }:
{
    nixpkgs.config.allowUnfree = true;
    home.stateVersion = "22.11";
    programs.home-manager.enable = true;
    imports = [
        ./modules/cabal.nix
        ./modules/darcs.nix
        ./modules/ghci.nix
        ./modules/haskeline.nix

        ./audacity
        ./backgrounds
        ./cabal.nix
        ./darcs.nix
        ./firefox.nix
        ./fish.nix
        ./fonts.nix
        ./ghci.nix
        ./git.nix
        ./haskeline.nix
        (let f = import ./packages.nix; in args: f (args // { inherit pkgs; pkgsUnstable = import <nixpkgs-unstable> config; }))
        ./ssh.nix
        ./tmux.nix
        ./vim.nix
        ./vscode.nix
        ./xdg.nix
    ];
}
