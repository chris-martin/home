{
    nix.settings = {
        auto-optimise-store = true;
        nix-path = [ "/home/chris/.config/nix-path" ];
        experimental-features = [ "nix-command" "flakes" ];
    };
}
