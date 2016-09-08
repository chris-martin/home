Source the script appropriate for your shell from the `shell` directory
to set up environment variables for Nix stuff.

The Fish script provides a `nix` function that can be used to do everything
I do with Nix.

## Channels

The `nix` script will update the channel list automatically.

The root channel list can be empty.

    > sudo nix-channel --list
    [no output]
