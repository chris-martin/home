{ pkgs, ... }:
{
    nixpkgs.config = import /home/chris/.config/nixpkgs/config.nix;
    home.stateVersion = "22.11";
    programs.firefox.enable = true;
    programs.home-manager.enable = true;
    imports = [
        ./modules/ghci.nix

        ./fish.nix
        ./fonts.nix
        ./ghci.nix
        ./git.nix
        ./packages.nix
        ./ssh.nix
        ./tmux.nix
        ./vim.nix
        ./vscode.nix
    ];
}
