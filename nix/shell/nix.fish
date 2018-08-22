set -x NIX_PATH "$HOME/nix/path"
set -x NIXPKGS_CONFIG "$HOME/nix/config.nix"
set -x NIXOS_CONFIG "$HOME/nix/os/config.nix"


#-------------------------------------------------------------------
#  The great nix function
#-------------------------------------------------------------------

function nix
  switch $argv[1]

  case channels
    nix-channel --list

  case update
    nix-channel --update

  case rebuild-os
    sudo env \
      NIX_PATH="$NIX_PATH" \
      NIXOS_CONFIG="$NIXOS_CONFIG" \
      nixos-rebuild switch --option substituters 'https://cache.nixos.org'

  case packages
    nix-env -q

  case install
    nix-env --keep-going --file '<nixpkgs>' --install --attr $argv[2]

  case uninstall remove
    nix-env -f '<nixpkgs>' -e $argv[2]

  case path
    nix-store -r (nix drv $argv[2])

  case drv
    nix-instantiate '<nixpkgs>' -A $argv[2]

  case gc
    sudo nix-collect-garbage --delete-older-than $argv[2]

  case '*'
    env nix $argv[1..(count $argv)]

  end
end
