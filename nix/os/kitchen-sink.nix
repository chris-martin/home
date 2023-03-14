{ pkgs, ... }:
let
  unstable = pkgs.nixpkgs-unstable;
  haskellStuff =
    let
      pkgs = unstable;
      compilers =
        [
          (pkgs.haskell.packages.ghc94.ghcWithPackages (p: [ p.digest p.postgresql-libpq p.unix p.zlib ]))
          (pkgs.haskell.packages.ghc92.ghcWithPackages (p: [ p.digest p.postgresql-libpq p.unix p.zlib ]))
          (pkgs.haskell.packages.ghc90.ghcWithPackages (p: [ p.digest p.postgresql-libpq p.unix p.zlib ]))
          (pkgs.haskell.packages.ghc8107.ghcWithPackages (p: [ p.digest p.postgresql-libpq p.unix p.zlib ]))
        ];

      hls = pkgs.haskell-language-server.override {
        supportedGhcVersions = ["810" "90" "92" "94"];
      };
    in
      compilers ++ [
        hls
        pkgs.cabal-install
        unstable.cabal2nix
        #pkgs.ghcid
        #pkgs.hindent
        #pkgs.hlint
        #pkgs.hpack
        #pkgs.stack
      ];
in
{
  environment.systemPackages = haskellStuff ++ [
    #pkgs.abcde # audio CD ripping
    #pkgs.ack
    #pkgs.alock
    #pkgs.alsaUtils
    #pkgs.alsamixer # audio controls
    #pkgs.android-udev-rules
    #pkgs.ansifilter
    #pkgs.audacity
    #pkgs.arcanist
    #pkgs.astyle
    #pkgs.atom # text editor
    #pkgs.awscli
    pkgs.baobab # disk usage inspector
    #pkgs.binutils
    pkgs.cachix
    #pkgs.calibre
    #pkgs.cheese # Camera GUI
    #pkgs.chromium
    #pkgs.choose-exe # Chooses random elements from a stream
    pkgs.cryptsetup # LUKS disk encryption
    pkgs.curl
    #pkgs.discord
    #pkgs.dmenu
    #pkgs.doctest
    #pkgs.elmPackages.elm
    #pkgs.elmPackages.elm-format
    #pkgs.entr
    pkgs.eog # "eye of gnome" image viewer
    pkgs.evince # PDF viewer
    #pkgs.exercism
    #pkgs.ffmpeg-full
    #pkgs.ffmpegthumbnailer # enables video thumbnails in Nautilus
    pkgs.file-roller # zip GUI
    pkgs.fish # shell
    #pkgs.fontforge
    #pkgs.FractalArt
    #pkgs.fullwidth # converts strings to their fullwidth forms
    #pkgs.gcc # C compiler
    #pkgs.gnome3.dconf-editor
    pkgs.gnome3.gedit
    #pkgs.ghostscript
    pkgs.gimp # umage editor
    pkgs.gitAndTools.gitFull
    #pkgs.gitAndTools.git-bz
    #pkgs.gitAndTools.git-extras
    #pkgs.github-cli
    #pkgs.gksu
    #pkgs.glances
    pkgs.glib.dev # provides the "gio" command
    #pkgs.gmrun
    pkgs.gnome-screenshot # screenshot tool
    #pkgs.gopher
    #pkgs.gparted # partitioning tool
    #pkgs.gptfdisk # partitioning tool
    pkgs.gnome3.gnome-terminal
    pkgs.gnucash # accounting
    pkgs.gnumake # make
    pkgs.gnupg
    #pkgs.go
    #pkgs.google-chrome
    #pkgs.graphviz
    #pkgs.guvcview # for recording from a webcam
    pkgs.htop
    pkgs.imagemagick7 # CLI image editor
    pkgs.inkscape # SVG editor
    #pkgs.intellij # IntelliJ IDEa
    #pkgs.inxi
    pkgs.iw # wireless network manager
    #pkgs.jmtpfs # Android filesystem mounting
    #pkgs.jq
    pkgs.kcolorchooser
    #pkgs.kdenlive
    pkgs.konsole
    pkgs.libnotify
    pkgs.libreoffice
    pkgs.lsof # list open files
    #pkgs.lynx
    pkgs.man
    pkgs.man-pages
    #pkgs.meld # diff tool
    #pkgs.minecraft
    #pkgs.mlt
    #pkgs.moc # "music on console" CLI music player
    #pkgs.moreutils
    #pkgs.mpv # video player
    #pkgs.mtools
    pkgs.nautilus
    #pkgs.ncdu
    #pkgs.netcat-gnu
    pkgs.niv
    #pkgs.nix-prefetch-scripts
    #pkgs.nix-repl # REPL for the Nix language
    #pkgs.nixops # the Nix ops tool
    #pkgs.nodejs # javascript repl
    #pkgs.obs-studio
    pkgs.okular # PDF viewer
    pkgs.ormolu
    #pkgs.pandoc
    #pkgs.pandora # internet music
    pkgs.pass
    #pkgs.pciutils
    pkgs.pdftk
    pkgs.psmisc # contains killall
    #pkgs.pssh
    #pkgs.python3
    #pkgs.python3Packages.ipython # Python REPL
    #pkgs.rlwrap
    #pkgs.rip-cd
    pkgs.rsync
    #pkgs.sassc
    pkgs.scrot # screenshot tool
    pkgs.silver-searcher # the "ag" command
    pkgs.slack
    #pkgs.solaar
    pkgs.sshfs-fuse # SSH mount
    #pkgs.socat
    #pkgs.stack2nix
    #pkgs.stylish-haskell # Haskell code formatter
    #pkgs.sublime # text editor
    #pkgs.sws
    pkgs.system-config-printer
    #pkgs.telnet
    #pkgs.tesseract # OCR
    (pkgs.texlive.combine { inherit (pkgs.texlive) scheme-small; })
    # pkgs.text-replace
    pkgs.tmux
    pkgs.totem
    pkgs.traceroute
    #pkgs.transmission_gtk # bittorrent
    pkgs.tree
    pkgs.wordlist # password generator
    #pkgs.usbutils
    #pkgs.unetbootin
    pkgs.unzip
    pkgs.vim # text editor
    pkgs.vscode
    pkgs.wezterm
    pkgs.wget
    #pkgs.wine
    pkgs.which
    pkgs.whois
    #pkgs.woff2
    pkgs.vscode
    pkgs.xclip # CLI utility for the X clipboard
    #pkgs.xorg.xev
    #pkgs.xournal # PDF editor
    pkgs.xkill # kill X windows by clicking on them
    pkgs.zip
    pkgs.zoom-us
  ];
}
