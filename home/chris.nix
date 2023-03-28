{ nixpkgs, config, ... }: {
  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;
  programs.firefox.enable = true;
  imports = [
    ./generic/cabal.nix
    ./generic/darcs.nix
    ./generic/ghci.nix
    ./generic/haskeline.nix

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
    ./vscode
    ./xdg.nix
  ];
}
