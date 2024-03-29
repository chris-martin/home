{ nixpkgs, editor, ... }: {
  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "22.11";

  imports = [
    ./generic

    (import ./modules/fish { inherit nixpkgs editor; })
    ./modules/git
    ./modules/packages.nix
    ./modules/tmux.nix
    ./modules/xdg.nix
  ];

  fonts.fontconfig.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.cabal = {
    enable = true;
    installDirectory = "/home/chris/.cabal/bin";
    username = "chris_martin";
    passwordCommand = let pkgs = nixpkgs.from.stable; in "${pkgs.writeShellScript "print-hackage-password" ''
      ${pkgs.pass}/bin/pass show computer/haskell/hackage | ${pkgs.coreutils}/bin/head -n1
    ''}";
  };

  programs.darcs = {
    author = [ "Chris Martin <ch.martin@gmail.com>" ];
    boring = [ "^.idea$" ".iml$" "^.stack-work$" ];
  };

  programs.ghci = {
    enable = true;
    prompt = "\\n\\ESC[1;35m\\x03BB> \\ESC[m";
    promptContinue = "\\ESC[1;35m > \\ESC[m";
    multiline = true;
  };

  programs.home-manager.enable = true;

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "*".identityFile = "/home/chris/.ssh/default-key";
      "chris-martin.org".port = 36411;
    };
  };

}
