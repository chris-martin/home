with rec {
  pkgs = nixos-stable // {
    all      = all;
    stable   = stable;
    unstable = unstable;
  };

  channelPath = name:
    (builtins.getEnv "HOME") + "/.nix-defexpr/channels/"
    + name + "/pkgs/top-level/all-packages.nix";

  channel = name: import (channelPath name) { config = config; };

  nixos-stable   = channel "nixos-15.09";
  nixos-unstable = channel "nixos-unstable";

  config.allowUnfree = true;

  config.chromium = {
    enablePepperFlash = true;
    enablePepperPDF   = true;
    enableWideVine    = true;
  };

  all = with nixos-stable; buildEnv {
    name = "all";
    paths = [ stable unstable ];
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

  unstable = with nixos-unstable; buildEnv {
    name = "unstable";
    paths = [

      (emacsWithPackages (x: with x; [   # Emacs
        diff-hl
        flycheck
        flycheck-haskell
        melpaPackages.helm
        melpaPackages.helm-projectile
        ido-ubiquitous
        markdown-mode
        magit
        mwim
        neotree
        nix-mode
        projectile
        tabbar
        ws-butler
        yaml-mode
      ]))

    ];
  };

}; pkgs
