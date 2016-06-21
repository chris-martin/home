export NIXPKGS_CONFIG="$HOME/nix/config.nix"

export NIX_PATH="\
nixpkgs=$HOME/.nix-defexpr/channels/nixos-16.03:\
nixpkgs-unstable=$HOME/.nix-defexpr/channels/nixos-unstable:\
nixos-config=$HOME/nix/os/config.nix"
