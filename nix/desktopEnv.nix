{ config, pkgs }:
with pkgs;
buildEnv {
  name = "desktopEnv";
  paths = [

    choose wordlist

    ack alock ansifilter arcanist astyle awscli gksu rsync unetbootin solaar libnotify abcde

    ffmpegthumbnailer # Enables video thumbnails in Nautilus

    jmtpfs                             # Android

    zip unzip file-roller              # Archives

    gcc gnumake                        # Build

    cheese                             # Camera

    google-chrome                      # Chrome

    gnupg1compat keepassx2 easyrsa     # Crypto
    libbitcoin-explorer cryptsetup

    sassc                              # CSS

    meld                               # Diff tools

    evince eog okular                  # Doc/image viewers

    bridge-utils docker-compose        # Docker

    vim sublime3 atom                  # Editors
    jetbrains.idea-community

    gitAndTools.gitFull                # Git
    gitAndTools.hub
    gitAndTools.git-extras
    gitAndTools.git-bz

    go go2nix                          # Go

    cabal stylish-haskell              # Haskell
    cabal2nix hasktags
    pointfree pointful ghc
    hdevtools hoogle intero
    stack

    curl wget                          # HTTP

    gimp imagemagick inkscape          # Image editing
    kcolorchooser pdftk
    graphviz ghostscript

    openjdk8 sbt scala                 # JVM

    nodejs npm2nix grunt bower         # Javascript

    jq                                 # JSON

    moc pandora                        # Music

    iw nmap                            # Networking

    nix-repl nix-prefetch-scripts      # Nix

    tesseract                          # OCR

    gparted gptfdisk                   # Partitioning

    python python35Packages.ipython    # Python

    scrot gnome-screenshot             # Screenshots

    fish tmux tmuxp man rlwrap tree    # Shell
    which moreutils mtools
    silver-searcher pssh

    sshfsFuse                          # SSH mount

    htop lsof psmisc pciutils          # System inspection
    baobab ncdu glances

    skype                              # Telephony

    transmission_gtk                   # Torrent

    usbutils                           # USB

    alsamixer ffmpeg mpv               # Video/audio

    xclip xkill                        # X utils
  ];
}
