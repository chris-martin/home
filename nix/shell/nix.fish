set -x NIXPKGS_CONFIG "$HOME/nix/config.nix"

set -x NIX_PATH "\
nixpkgs=$HOME/.nix-defexpr/channels/nixos-16.03:\
nixos-config=$HOME/nix/os/config.nix"
