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


#-------------------------------------------------------------------
#  The great nix function
#-------------------------------------------------------------------

function nix
  switch $argv[1]

  case rebuild-os
    sudo env NIX_PATH=$NIXOS_PATH nixos-rebuild switch

  case packages
    nix-env -q

  case install
    nix-env -f '<nixpkgs>' -iA $argv[2]

  case uninstall remove
    nix-env -f '<nixpkgs>' -e $argv[2]

  case update
    __fish_nix_set_channels
    nix-channel --update

  case shell
    nix-shell $argv[2..-1]

  case build
    nix-build $argv[2..-1]

  case path
    nix-store -r (nix drv $argv[2])

  case drv
    nix-instantiate '<nixpkgs>' -A $argv[2]

  # To manually walk through the build process for some package
  case debug
    cd (mktemp -d)
    nix-shell '<nixpkgs>' -A $argv[2] --pure

  case gc
    nix-collect-garbage --delete-older-than $argv[2]

  case optimise optimize
    nix-store --optimise

  case '*'
    echo "???"

  end
end

function __fish_nix_set_channels

  for c in (nix-channel --list | cut -d ' ' -f 1)
    nix-channel --remove $c
  end

  nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
  nix-channel --add https://nixos.org/channels/nixos-16.09    nixos-16.09
  nix-channel --add https://nixos.org/channels/nixos-16.03    nixos-16.03
  nix-channel --add https://nixos.org/channels/nixos-15.09    nixos-15.09
end


#-------------------------------------------------------------------
#  Tab completion for the nix function
#-------------------------------------------------------------------

function __fish_nix_needs_command
  set cmd (commandline -opc)
  if [ (count $cmd) -eq 1 ]
    return 0
  else
    return 1
  end
end

complete -f -c nix -a rebuild-os \
  -n __fish_nix_needs_command \
  -d "Rebuild NixOS"

complete -f -c nix -a packages \
  -n __fish_nix_needs_command \
  -d "List installed packages"

complete -f -c nix -a install \
  -n __fish_nix_needs_command \
  -d "Install a package"

complete -f -c nix -a uninstall \
  -n __fish_nix_needs_command \
  -d "Uninstall a package"

complete -f -c nix -a update \
  -n __fish_nix_needs_command \
  -d "Download from channels"

complete -f -c nix -a shell \
  -n __fish_nix_needs_command \
  -d "Run nix-shell"

complete -f -c nix -a build \
  -n __fish_nix_needs_command \
  -d "Run nix-build"

complete -f -c nix -a path \
  -n __fish_nix_needs_command \
  -d "Find a package in /nix/store"

complete -f -c nix -a drv \
  -n __fish_nix_needs_command \
  -d "Find a derivation in /nix/store"

complete -f -c nix -a debug \
  -n __fish_nix_needs_command \
  -d "Step through a build"

complete -f -c nix -a gc \
  -n __fish_nix_needs_command \
  -d "Garbage collection on /nix/store"

complete -f -c nix -a optimise \
  -n __fish_nix_needs_command \
  -d "Reduce disk space usage"
