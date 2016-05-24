{ config, pkgs }:
with pkgs;
buildEnv {
  name = "serverEnv";
  paths = [

    zip unzip                          # Archives

    vim                                # Editors

    gitAndTools.gitFull                # Git

    curl wget                          # HTTP

    jq                                 # JSON

    nmap                               # Networking

    nix-repl                           # Nix

    gptfdisk                           # Partitioning

    fish tmux man tree which           # Shell

    htop lsof psmisc pciutils ncdu     # System inspection
  ];
}
