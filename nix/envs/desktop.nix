{ config, pkgs }:
with pkgs;
buildEnv {
  name = "desktopEnv";
  paths = [

    choose wordlist

    ack

    gnupg

    rsync

    jmtpfs                             # Android

    zip unzip file-roller              # Archives

    gcc gnumake                        # Build

    cheese                             # Camera

    chromium                           # Chromium

    keepassx2 truecrypt                # Crypto

    sassc                              # CSS

    meld                               # Diff tools

    evince eog                         # Doc/image viewers

    bridge-utils docker-compose        # Docker

    vim idea.idea15-ultimate sublime   # Editors
    atom

    ((import "${config.home}/emacs/emacs.nix") pkgs) # Emacs

    go-ethereum                        # Ethereum

    steam minecraft                    # Gaming

    gitAndTools.gitFull                # Git
    gitAndTools.hub
    gitAndTools.git-extras

    cabal stylish-haskell hlint        # Haskell
    cabal2nix stack hasktags
    pointfree pointful ghc ghc-mod

    curl wget                          # HTTP

    gimp imagemagick inkscape          # Image editing
    kcolorchooser

    openjdk8 sbt scala                 # JVM

    nodejs npm2nix grunt bower         # Javascript
    purescript

    jq                                 # JSON

    moc pandora                        # Music

    iw nmap                            # Networking

    nix-repl nix-prefetch-scripts      # Nix
    nix-shell-wrapper

    tesseract                          # OCR

    gparted gptfdisk                   # Partitioning

    python                             # Python

    scrot gnome-screenshot             # Screenshots

    fish tmux man rlwrap tree which    # Shell

    sshfsFuse                          # SSH mount

    htop lsof psmisc pciutils          # System inspection
    baobab ncdu

    skype                              # Telephony

    transmission_gtk                   # Torrent

    usbutils                           # USB

    alsamixer ffmpeg mpv               # Video/audio

    xclip xkill                        # X utils
  ];
}
