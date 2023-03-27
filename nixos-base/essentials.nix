{ pkgs, ... }: {
  environment.systemPackages = [
    pkgs.bash # shell
    pkgs.curl # HTTP client
    pkgs.fish # shell
    pkgs.gparted # partitioning tool
    pkgs.gptfdisk # partitioning tool
    pkgs.htop # view list of running processes
    pkgs.lsof # list open files
    pkgs.man
    pkgs.man-db
    pkgs.networkmanager
    pkgs.openssl
    pkgs.p7zip
    pkgs.parted
    pkgs.rsync
    pkgs.silver-searcher # the "ag" command
    pkgs.tmux # terminal multiplexer
    pkgs.tree
    pkgs.vim # command-line text editor
    pkgs.wget # HTTP client
    pkgs.which
    pkgs.whois
    pkgs.xorg.xkill # kill X windows by clicking on them
    pkgs.zip
    pkgs.unzip
  ];
}
