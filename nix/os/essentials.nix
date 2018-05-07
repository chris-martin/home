{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.curl
    pkgs.fish
    pkgs.gparted
    pkgs.gptfdisk
    pkgs.htop
    pkgs.lsof
    pkgs.man_db
    pkgs.openssl
    pkgs.tmux
    pkgs.tree
    pkgs.vim
    pkgs.wget
    pkgs.which
    pkgs.zip
    pkgs.unzip
  ];
}
