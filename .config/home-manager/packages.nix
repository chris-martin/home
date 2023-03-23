{ pkgs, config, ... }:
let
    pkgs' = import <nixpkgs-unstable> config;
in
{
    home.packages = [

        # Graphical

        pkgs.baobab # disk usage analyzer
        pkgs.eog # image viewer
        pkgs.evince # PDF viewer
        pkgs.file-roller # file compression

        # Command-line

        pkgs.bash pkgs.fish # shells
        pkgs'.cabal2nix # generates Nix expressions for Haskell packages
        pkgs.cachix # set up and use Nix binary caches hosted by Cachix
        pkgs.cryptsetup # LUKS
        pkgs.curl pkgs.wget # HTTP clients
        pkgs.glib.dev # provides the "gio" command
        pkgs.gnupg # encryption
        pkgs.htop # view list of running processes
        pkgs.lsof # list open files
        pkgs.man pkgs.man-db # documentation
        pkgs.niv # nix version manager
        pkgs.pass # password manager
        pkgs.psmisc # contains killall
        pkgs.rsync # move files locally or via network
        pkgs.silver-searcher # file searching, the "ag" command
        pkgs.tmux # terminal multiplexer
        pkgs.tree # list files hierarchically
        pkgs.which # path lookup
        pkgs.whois # network domain lookup
#        (builtins.getFlake "github:chris-martin/wordlist/5e7b4641248758b0433f37633f77095c0094aa00").defaultPackage.x86_64-linux # password generator
        pkgs.xclip # clipboard tool
        pkgs.xkill # kill X windows by clicking on them
        pkgs.zip pkgs.unzip # file compression
    ];
}
