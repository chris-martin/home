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

    keepassx2 cryptsetup               # Crypto

    meld                               # Diff tools

    evince eog okular                  # Doc/image viewers

    vim sublime3 atom                  # Editors
    jetbrains.idea-community

    gitAndTools.gitFull                # Git
    gitAndTools.hub
    gitAndTools.git-extras
    gitAndTools.git-bz

    stack stylish-haskell              # Haskell
    (haskell.packages.ghc821.ghcWithPackages (p: with p; [
      ghc cabal-install
    ]))

    curl wget                          # HTTP

    gimp imagemagick inkscape          # Image editing
    kcolorchooser pdftk
    graphviz ghostscript

    moc pandora                        # Music

    iw nmap                            # Networking

    nix-repl nix-prefetch-scripts      # Nix

    tesseract                          # OCR

    gparted gptfdisk                   # Partitioning

    python35Packages.ipython           # Python

    scrot gnome-screenshot             # Screenshots

    fish tmux tmuxp man rlwrap tree    # Shell
    which moreutils mtools
    silver-searcher pssh

    sshfsFuse                          # SSH mount

    htop lsof psmisc pciutils          # System inspection
    baobab ncdu glances

    transmission_gtk                   # Torrent

    usbutils                           # USB

    alsamixer ffmpeg mpv               # Video/audio

    xclip xkill                        # X utils
  ];
}
