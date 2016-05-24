{ config, pkgs }:
with pkgs;
buildEnv {
  name = "desktopEnv";
  paths = [

    ack

    jmtpfs                             # Android

    zip unzip gnome3.file-roller       # Archives

    chromium                           # Chromium

    keepassx2 truecrypt                # Crypto

    sassc                              # CSS

    meld                               # Diff tools

    evince gnome3.eog                  # Doc/image viewers

    bridge-utils                       # Docker
    pythonPackages.docker_compose

    vim idea.idea15-ultimate           # Editors

    ((import "${config.home}/emacs/emacs.nix") pkgs) # Emacs

    steam minecraft                    # Gaming

    gitAndTools.gitFull                # Git
    gitAndTools.hub

    haskellPackages.cabal-install      # Haskell
    haskellPackages.stack
    haskellPackages.stylish-haskell
    haskellPackages.cabal2nix

    curl wget                          # HTTP

    gimp imagemagick inkscape          # Image editing
    kcolorchooser

    polari konversation                # IRC

    openjdk8                           # JVM

    npm npm2nix                        # Javascript

    jq                                 # JSON

    moc pandora                        # Music

    nmap                               # Networking
    nix-repl nix-prefetch-scripts      # Nix

    tesseract                          # OCR

    gparted gptfdisk                   # Partitioning

    scrot gnome3.gnome-screenshot      # Screenshots

    fish tmux man tree which           # Shell

    sshfsFuse                          # SSH mount

    htop lsof psmisc pciutils          # System inspection
    baobab ncdu

    skype                              # Telephony

    transmission_gtk                   # Torrent

    usbutils

    alsamixer ffmpeg mpv vlc           # Video/audio
    gnome3.totem gstreamer

    xclip xorg.xkill                   # X utils
  ];
}
