{ config, pkgs }:
with pkgs;
buildEnv {
  name = "desktopEnv";
  paths = [

    ack

    gnumake

    jmtpfs                             # Android

    zip unzip file-roller              # Archives

    chromium                           # Chromium

    keepassx2 truecrypt                # Crypto

    sassc                              # CSS

    meld                               # Diff tools

    evince eog                         # Doc/image viewers

    bridge-utils docker-compose        # Docker

    vim idea.idea15-ultimate sublime   # Editors

    ((import "${config.home}/emacs/emacs.nix") pkgs) # Emacs

    geth                               # Ethereum

    steam minecraft                    # Gaming

    gitAndTools.gitFull                # Git
    gitAndTools.hub

    cabal stack stylish-haskell        # Haskell
    cabal2nix

    curl wget                          # HTTP

    gimp imagemagick inkscape          # Image editing
    kcolorchooser

    polari konversation                # IRC

    openjdk8                           # JVM

    nodejs npm2nix                     # Javascript

    jq                                 # JSON

    moc pandora                        # Music

    nmap                               # Networking

    nix-repl nix-prefetch-scripts      # Nix

    tesseract                          # OCR

    gparted gptfdisk                   # Partitioning

    scrot gnome-screenshot             # Screenshots

    fish tmux man tree which           # Shell

    sshfsFuse                          # SSH mount

    htop lsof psmisc pciutils          # System inspection
    baobab ncdu

    skype                              # Telephony

    transmission_gtk                   # Torrent

    usbutils

    alsamixer ffmpeg mpv               # Video/audio

    xclip xkill                        # X utils
  ];
}
