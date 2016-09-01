set -x NIXPKGS_CONFIG "$HOME/nix/config.nix"

set CHANNELS "$HOME/.nix-defexpr/channels"

set -x NIX_PATH "\
nixpkgs=$CHANNELS/nixos-16.03:\
nixpkgs-unstable=$CHANNELS/nixos-unstable"

set -x NIXOS_PATH "\
nixpkgs=$CHANNELS/nixos-16.03:\
nixpkgs-unstable=$CHANNELS/nixos-unstable:\
nixos-config=$HOME/nix/os/config.nix"
