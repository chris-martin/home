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

      # Editors
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

  config.systemd.user.services.emacs = {

    description = "Emacs Daemon";

    environment = {
      GTK_DATA_PREFIX = config.system.path;
      SSH_AUTH_SOCK   = "%t/ssh-agent";
      GTK_PATH        = "${config.system.path}/lib/gtk-3.0:${config.system.path}/lib/gtk-2.0";
      NIX_PROFILES    = "${pkgs.lib.concatStringsSep " " config.environment.profiles}";
      TERMINFO_DIRS   = "/run/current-system/sw/share/terminfo";
      ASPELL_CONF     = "dict-dir /run/current-system/sw/lib/aspell";
    };

    serviceConfig = {
      Type      = "forking";
      ExecStart = "${pkgs.bash}/bin/bash -c 'source ${config.system.build.setEnvironment} emacs --daemon --no-desktop'";
      ExecStop  = "${pkgs.emacs}/bin/emacsclient --eval '(kill-emacs)'";
      Restart   = "always";
    };

    wantedBy = [ "default.target" ];
  };

  config.systemd.services.emacs.enable = true;

}; pkgs
