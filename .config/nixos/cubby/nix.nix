{
    nix.settings = {
        trusted-users = [ "@wheel" ];
        max-jobs = 8;
        build-cores = 0;
    };
}
