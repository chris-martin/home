{ nixpkgs, ... }: {

  home.packages = [

    # Graphical

    nixpkgs.from.stable.baobab # disk usage analyzer
    nixpkgs.from.stable.gnome3.eog # image viewer
    nixpkgs.from.stable.evince # PDF viewer
    nixpkgs.from.stable.gnome3.file-roller # file compression

    # Command-line

    nixpkgs.from.stable.bash
    nixpkgs.from.stable.fish # shells
    nixpkgs.from.unstable.cabal2nix # generates Nix expressions for Haskell packages
    nixpkgs.from.stable.cachix # set up and use Nix binary caches hosted by Cachix
    nixpkgs.from.stable.cryptsetup # LUKS
    nixpkgs.from.stable.curl
    nixpkgs.from.stable.wget # HTTP clients
    nixpkgs.from.stable.glib.dev # provides the "gio" command
    nixpkgs.from.stable.gnupg # encryption
    nixpkgs.from.stable.htop # view list of running processes
    nixpkgs.from.stable.lsof # list open files
    nixpkgs.from.stable.man
    nixpkgs.from.stable.man-db # documentation
    nixpkgs.from.stable.niv # nix version manager
    nixpkgs.from.stable.pass # password manager
    nixpkgs.from.stable.psmisc # contains killall
    nixpkgs.from.stable.rsync # move files locally or via network
    nixpkgs.from.stable.silver-searcher # file searching, the "ag" command
    nixpkgs.from.stable.tree # list files hierarchically
    nixpkgs.from.stable.wezterm # terminal emulator
    nixpkgs.from.stable.which # path lookup
    nixpkgs.from.stable.whois # network domain lookup
    (builtins.getFlake
      "github:chris-martin/wordlist/5e7b4641248758b0433f37633f77095c0094aa00").defaultPackage.x86_64-linux # password generator
    nixpkgs.from.stable.xclip # clipboard tool
    nixpkgs.from.stable.xorg.xkill # kill X windows by clicking on them
    nixpkgs.from.stable.zip
    nixpkgs.from.stable.unzip # file compression

    # Fonts

    nixpkgs.from.stable.corefonts
    nixpkgs.from.stable.fira
    nixpkgs.from.stable.fira-code
    nixpkgs.from.stable.fira-mono
    nixpkgs.from.stable.lato
    nixpkgs.from.stable.merriweather
    nixpkgs.from.stable.monoid
    (nixpkgs.from.stable.google-fonts.override { fonts = [ "BioRhyme" ]; })
    (nixpkgs.from.stable.google-fonts.override { fonts = [ "Bitter" ]; })
    (nixpkgs.from.stable.google-fonts.override { fonts = [ "Overlock SC" ]; })
    (nixpkgs.from.stable.google-fonts.override { fonts = [ "Redacted Script" ]; })
    nixpkgs.from.stable.hasklig
    nixpkgs.from.stable.helvetica-neue-lt-std
    nixpkgs.from.stable.inconsolata
    nixpkgs.from.stable.luculent
    nixpkgs.from.stable.profont
    nixpkgs.from.stable.source-sans-pro
    nixpkgs.from.stable.source-serif-pro
    nixpkgs.from.stable.symbola
    nixpkgs.from.stable.ubuntu_font_family
    nixpkgs.from.stable.unifont
    nixpkgs.from.stable.vistafonts

  ];
}
