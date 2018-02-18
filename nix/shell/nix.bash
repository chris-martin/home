export NIX_PATH="$HOME/nix/path"
export NIXPKGS_CONFIG="$HOME/nix/config.nix"
export NIXOS_CONFIG="$HOME/nix/os/config.nix"

function rebuild-os {
   sudo env \
     NIX_PATH="$NIX_PATH" \
     NIXOS_CONFIG="$NIXOS_CONFIG" \
     nixos-rebuild switch
}
