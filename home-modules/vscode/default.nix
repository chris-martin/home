{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    extensions = (import ./extensions.nix) pkgs.vscode-extensions;
    userSettings = import ./settings { inherit (pkgs) lib; };
    keybindings = import ./keybindings.nix;
  };
}
