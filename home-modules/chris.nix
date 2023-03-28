{ nixpkgs, config, ... }: {
  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;
  programs.firefox.enable = true;
  imports = [
    ./modules/cabal.nix
    ./modules/darcs.nix
    ./modules/ghci.nix
    ./modules/haskeline.nix

    ./cabal.nix
    ./darcs.nix
    ./fish
    ./fonts.nix
    ./ghci.nix
    ./git.nix
    ./haskeline.nix
    ./packages.nix
    ./ssh.nix
    ./tmux.nix
    ./vim.nix
    ./xdg.nix

    (import ./vscode { pkgs = nixpkgs.for.vscode; })
  ];
}
