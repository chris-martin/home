{ pkgs, ... }:
{
  hardware.u2f.enable = true; # enable yubikey

  environment.systemPackages = [
    #pkgs.abcde # audio CD ripping
    pkgs.ack
    pkgs.alock
    pkgs.alsaUtils
    #pkgs.alsamixer # audio controls
    pkgs.android-udev-rules
    pkgs.ansifilter
    pkgs.audacity
    pkgs.arcanist
    pkgs.astyle
    pkgs.atom # text editor
    pkgs.awscli
    pkgs.baobab # disk usage inspector
    pkgs.cabal-install
    pkgs.cabal2nix
    pkgs.cheese # Camera GUI
    pkgs.choose-exe # Chooses random elements from a stream
    pkgs.cryptsetup # LUKS disk encryption
    pkgs.curl
    pkgs.dmenu
    pkgs.doctest
    pkgs.entr
    pkgs.eog # "eye of gnome" image viewer
    pkgs.evince # PDF viewer
    pkgs.ffmpeg
    pkgs.ffmpegthumbnailer # enables video thumbnails in Nautilus
    pkgs.file-roller # zip GUI
    pkgs.fish # shell
    #pkgs.FractalArt
    pkgs.fullwidth # converts strings to their fullwidth forms
    pkgs.gcc # C compiler
    pkgs.gnome3.gedit
    pkgs.ghcid # Haskell GHCi daemon
    pkgs.ghostscript
    pkgs.gimp # umage editor
    pkgs.gitAndTools.gitFull
    pkgs.gitAndTools.git-bz
    pkgs.gitAndTools.git-extras
    pkgs.gksu
    pkgs.glances
    pkgs.glib.dev # provides the "gio" command
    pkgs.gmrun
    pkgs.gnome-screenshot # screenshot tool
    pkgs.gnumake # make
    pkgs.gparted # partitioning tool
    pkgs.gptfdisk # partitioning tool
    pkgs.graphviz
    pkgs.ghc
    pkgs.gnome-terminal
    pkgs.gnumake
    pkgs.gnupg
    pkgs.google-chrome
    pkgs.guvcview # for recording from a webcam
    pkgs.hindent
    pkgs.hlint
    pkgs.htop
    pkgs.imagemagick # CLI image editor
    pkgs.inkscape # SVG editor
    pkgs.intellij # IntelliJ IDEa
    pkgs.iw # wireless network manager
    pkgs.jmtpfs # Android filesystem mounting
    pkgs.kcolorchooser
    pkgs.kdenlive
    pkgs.libav
    pkgs.libnotify
    pkgs.libreoffice
    pkgs.lsof # list open files
    pkgs.man
    pkgs.manpages
    pkgs.meld # diff tool
    pkgs.moc # "music on console" CLI music player
    pkgs.moreutils
    pkgs.mpv # video player
    pkgs.mtools
    pkgs.nautilus
    pkgs.ncdu
    pkgs.netcat-gnu
    pkgs.nix-prefetch-scripts
    #pkgs.nix-repl # REPL for the Nix language
    pkgs.nixops # the Nix ops tool
    pkgs.nodejs # javascript repl
    pkgs.obs-studio
    pkgs.okular # PDF viewer
    pkgs.pandoc
    pkgs.pandora # internet music
    pkgs.pass
    pkgs.pciutils
    pkgs.pdftk
    pkgs.psmisc # contains killall
    pkgs.pssh
    pkgs.python36Packages.ipython # Python REPL
    pkgs.rlwrap
    pkgs.rip-cd
    pkgs.rsync
    pkgs.scrot # screenshot tool
    pkgs.silver-searcher # the "ag" command
    #pkgs.solaar
    pkgs.sshfsFuse # SSH mount
    pkgs.stack # Haskell build tool
    #pkgs.stack2nix
    pkgs.stylish-haskell # Haskell code formatter
    pkgs.sublime # text editor
    #pkgs.sws
    pkgs.tesseract # OCR
    #pkgs.text-replace
    pkgs.tmux
    pkgs.totem
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
    pkgs.xorg.xev
    pkgs.xournal # PDF editor
    pkgs.xkill # kill X windows by clicking on them
    pkgs.yi-chris-martin
    pkgs.zip
  ];
}
