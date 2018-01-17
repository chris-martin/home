{ pkgs }:
pkgs.buildEnv {
  name = "desktop-env";
  meta.priority = 10; # make this a low-priority package so ad hoc installs can override it
  paths = [
    pkgs.abcde # audio CD ripping
    pkgs.ack
    pkgs.alock
    pkgs.alsamixer # audio controls
    pkgs.ansifilter
    pkgs.arcanist
    pkgs.astyle
    pkgs.atom # text editor
    pkgs.awscli
    pkgs.baobab # disk usage inspector
    pkgs.cabal-install
    pkgs.cabal2nix
    pkgs.cheese # Camera GUI
    pkgs.choose # Chooses random elements from a stream
    pkgs.cryptsetup # LUKS disk encryption
    pkgs.curl
    pkgs.entr
    pkgs.eog # "eye of gnome" image viewer
    pkgs.evince # PDF viewer
    pkgs.ffmpeg
    pkgs.ffmpegthumbnailer # enables video thumbnails in Nautilus
    pkgs.file-roller # zip GUI
    pkgs.fish # shell
    pkgs.fullwidth # converts strings to their fullwidth forms
    pkgs.gcc # C compiler
    pkgs.ghostscript
    pkgs.gimp # umage editor
    pkgs.gitAndTools.gitFull
    pkgs.gitAndTools.git-bz
    pkgs.gitAndTools.git-extras
    pkgs.gitAndTools.hub
    pkgs.gksu
    pkgs.glances
    pkgs.gnome-screenshot # screenshot tool
    pkgs.gnumake # make
    pkgs.google-chrome # The web browser
    pkgs.gparted # partitioning tool
    pkgs.gptfdisk # partitioning tool
    pkgs.graphviz
    pkgs.ghc
    pkgs.htop
    pkgs.imagemagick # CLI image editor
    pkgs.inkscape # SVG editor
    pkgs.intellij # IntelliJ IDEa
    pkgs.iw # wireless network manager
    pkgs.jmtpfs # Android filesystem mounting
    pkgs.kcolorchooser
    pkgs.keepassx2 # password manager
    pkgs.libnotify
    pkgs.lsof # list open files
    pkgs.man
    pkgs.meld # diff tool
    pkgs.moc # "music on console" CLI music player
    pkgs.moreutils
    pkgs.mpv # video player
    pkgs.mtools
    pkgs.ncdu
    pkgs.nix-prefetch-scripts
    pkgs.nix-repl # REPL for the Nix language
    pkgs.nixops # the Nix ops tool
    pkgs.okular # PDF viewer
    pkgs.pandora # internet music
    pkgs.pciutils
    pkgs.pdftk
    pkgs.psmisc
    pkgs.pssh
    pkgs.python35Packages.ipython # Python REPL
    pkgs.rsync
    pkgs.scrot # screenshot tool
    pkgs.silver-searcher # the "ag" command
    pkgs.solaar
    pkgs.sshfsFuse # SSH mount
    pkgs.stack # Haskell build tool
    pkgs.stylish-haskell # Haskell code formatter
    pkgs.sublime # text editor
    pkgs.tesseract # OCR
    pkgs.tmux
    pkgs.transmission_gtk # bittorrent
    pkgs.tree
    pkgs.wordlist # password generator
    pkgs.usbutils
    pkgs.unetbootin
    pkgs.unzip
    pkgs.vim # text editor
    pkgs.wget
    pkgs.which
    pkgs.xclip # CLI utility for the X clipboard
    pkgs.xkill # kill X windows by clicking on them
    pkgs.zip
  ];
}
