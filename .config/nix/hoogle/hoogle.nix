{ haskellPackages, ... }:
{
    services.hoogle = {
        enable = true;
        port = 13723;
        inherit haskellPackages;
        packages = import ./packages.nix;
    };
}
