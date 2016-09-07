set -x NIXPKGS_CONFIG "$HOME/nix/config.nix"

set NIXOS_CONFIG "$HOME/nix/os/config.nix"

set CHANNELS "$HOME/.nix-defexpr/channels"

set STABLE "$CHANNELS/nixos-16.09"

set NIX_PATH_BASE "\
nixpkgs-unstable=$CHANNELS/nixos-unstable:\
nixpkgs-16.09=$CHANNELS/nixos-16.09:\
nixpkgs-16.03=$CHANNELS/nixos-16.03"

set -x NIX_PATH "nixpkgs=$STABLE:$NIX_PATH_BASE"

set -x NIXOS_PATH "nixpkgs=$STABLE:nixos-config=$NIXOS_CONFIG:$NIX_PATH_BASE"
