CHANNELS="$HOME/.nix-defexpr/channels"

export NIXPKGS_CONFIG="$HOME/nix/config.nix"

export NIX_PATH="\
nixpkgs=$CHANNELS/nixos-16.09:\
nixpkgs-unstable=$CHANNELS/nixos-unstable"

export NIXOS_PATH="\
nixpkgs=$CHANNELS/nixos-16.09:\
nixpkgs-unstable=$CHANNELS/nixos-unstable:\
nixos-config=$HOME/nix/os/config.nix"
