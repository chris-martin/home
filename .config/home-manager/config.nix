{ pkgs, ... }:
{
    nixpkgs.config = import /home/chris/.config/nixpkgs/config.nix;
    home.stateVersion = "22.11";
    programs.firefox.enable = true;
    programs.home-manager.enable = true;
    imports = [
        ./fish.nix
        ./git.nix
        ./packages.nix
        ./vim.nix
        ./vscode.nix
    ];
}
