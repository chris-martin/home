with rec {
  pkgs = nixos-stable // {
    all      = all;
    stable   = stable;
    unstable = unstable;
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
    paths = [ stable unstable ];
  };

  stable = with nixos-stable; buildEnv {
    name = "stable";
    paths = [

      jmtpfs                             # Android

      zip unzip gnome3.file-roller       # Archives

      keepassx2 truecrypt                # Crypto

      sassc                              # CSS

      meld                               # Diff tools

      evince gnome3.eog                  # Doc/image viewers

      vim                                # Editors

      elixir rebar                       # Elixir

      steam minecraft                    # Gaming

      gitAndTools.gitFull                # Git
      gitAndTools.hub

      curl wget                          # HTTP

      gimp imagemagick inkscape          # Image editing

      gnome3.polari                      # IRC
      kde4.konversation

      jq                                 # JSON

      texLiveFull                        # LaTeX

      moc pithos                         # Music

      nmap                               # Networking

      nix-repl                           # Nix

      tesseract                          # OCR

      gparted gptfdisk                   # Partitioning

      scrot gnome3.gnome-screenshot      # Screenshots

      fish tmux man tree which           # Shell

      sshfsFuse                          # SSH mount

      htop lsof psmisc pciutils          # System inspection
      baobab ncdu

      skype                              # Telephony

      transmission_gtk                   # Torrent

      alsamixer ffmpeg mpv vlc           # Video/audio
      gnome3.totem gstreamer

      xclip xorg.xkill                   # X utils
    ];
  };

  unstable = with nixos-unstable; buildEnv {
    name = "unstable";
    paths = [

      chromium                           # Chromium

      bridge-utils                       # Docker

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

      haskellPackages.cabal-install      # Haskell
      haskellPackages.stack
      haskellPackages.stylish-haskell

      idea."idea-ultimate"               # IntelliJ
    ];
  };

}; pkgs
