Source the script appropriate for your shell from the shell directory
to set up environment variables for Nix stuff.

The channel list should look like this:

    > nix-channel --list
    nixos-unstable https://nixos.org/channels/nixos-unstable
    nixos-16.03 http://nixos.org/channels/nixos-16.03
    nixos-15.09 http://nixos.org/channels/nixos-15.09

The root channel list can be empty.

    > sudo nix-channel --list
    [no output]

To install packages for a desktop environment:

    nix-env -f '<nixpkgs>' -i desktopEnv

To rebuild the OS:

    sudo env NIX_PATH=$NIXOS_PATH nixos-rebuild switch

To go to the directory where some package is installed in the nix store:

    cd (nix-store -r (nix-instantiate '<nixpkgs>' -A foo))

To manually walk through the build process for some package:

    cd (mktemp -d)
    nix-shell '<nixpkgs>' -A foo --pure
