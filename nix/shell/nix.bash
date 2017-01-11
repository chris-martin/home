export NIXPKGS_CONFIG="$HOME/nix/config.nix"

NIXOS_CONFIG="$HOME/nix/os/config.nix"

export NIX_PATH=$HOME/nix/path

export NIXOS_PATH=$HOME/nix/path:nixos-config=$NIXOS_CONFIG
