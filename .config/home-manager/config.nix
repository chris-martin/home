{ pkgs, ... }:
{
    nixpkgs.config = import /home/chris/.config/nixpkgs/config.nix;
    home.stateVersion = "22.11";
    programs.firefox.enable = true;
    programs.home-manager.enable = true;
    imports = [
        ./fish.nix
        ./fonts.nix
        ./git.nix
        ./packages.nix
        ./ssh.nix
        ./vim.nix
        ./vscode.nix
    ];
}
