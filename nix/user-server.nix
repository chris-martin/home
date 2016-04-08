with rec {
  pkgs = nixos-stable // {
    all      = all;
    stable   = stable;
  };

  channelPath = name: file:
    "${builtins.getEnv "HOME"}/.nix-defexpr/channels/${name}/pkgs/top-level/${file}";

  channel = name: file: import (channelPath name file) { config = config; };

  nixos-stable   = channel "nixos-15.09" "all-packages.nix";
  nixos-unstable = channel "nixos-unstable" "default.nix";

  config.allowUnfree = true;

  config.chromium = {
    enablePepperFlash = true;
    enablePepperPDF   = true;
    enableWideVine    = true;
  };

  all = with nixos-stable; buildEnv {
    name = "all";
    paths = [ stable ];
  };

  stable = with nixos-stable; buildEnv {
    name = "stable";
    paths = [

      zip unzip                          # Archives

      vim                                # Editors

      gitAndTools.gitFull                # Git

      curl wget                          # HTTP

      jq                                 # JSON

      nmap                               # Networking

      nix-repl                           # Nix

      gptfdisk                           # Partitioning

      fish tmux man tree which           # Shell

      htop lsof psmisc pciutils ncdu     # System inspection

    ];
  };

}; pkgs
