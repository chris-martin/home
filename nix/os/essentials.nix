{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.curl
    pkgs.fish
    pkgs.gparted
    pkgs.gptfdisk
    pkgs.htop
    pkgs.lsof
    pkgs.man-db
    pkgs.networkmanager
    pkgs.openssl
    pkgs.p7zip
    pkgs.parted
    pkgs.tmux
    pkgs.tree
    pkgs.vim
    pkgs.wget
    pkgs.which
    pkgs.zip
    pkgs.unzip
  ];
}
