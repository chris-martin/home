{ pkgs, ... }:
{
    programs.vscode = {
        enable = true;
        extensions = import ./extensions.nix { inherit pkgs; };
        userSettings = import ./settings { inherit (pkgs) lib; };
        keybindings = import ./keybindings.nix;
    };
}
