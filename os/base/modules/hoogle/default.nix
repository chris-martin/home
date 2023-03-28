{
    services.hoogle = {
        packages = import ./packages.nix;
        port = 13723;
    };
}
