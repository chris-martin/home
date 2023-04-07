{ nixpkgs, ... }:
let pkgs = nixpkgs.for.vscode;
in {
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    extensions = (import ./extensions.nix) pkgs.vscode-extensions;
    userSettings = import ./settings { inherit (pkgs) lib; };
    keybindings = import ./keybindings.nix;
  };
}
