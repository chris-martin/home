export NIXPKGS_CONFIG="$HOME/nix/config.nix"

NIXOS_CONFIG="$HOME/nix/os/config.nix"

CHANNELS="$HOME/.nix-defexpr/channels"

STABLE="$CHANNELS/nixos-16.09"

NIX_PATH_BASE="\
nixpkgs-unstable=$CHANNELS/nixos-unstable:\
nixpkgs-16.09=$CHANNELS/nixos-16.09:\
nixpkgs-16.03=$CHANNELS/nixos-16.03"

export NIX_PATH="nixpkgs=$STABLE:$NIX_PATH_BASE"

export NIXOS_PATH="nixpkgs=$STABLE:nixos-config=$NIXOS_CONFIG:$NIX_PATH_BASE"
