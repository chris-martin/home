{
  inputs = {
    # base.url = "/home/chris/cdm-nixos-base";
    base.url = "github:chris-martin/cdm-nixos-base";

    # Nix library functions
    nixpkgs-for-lib.url = "github:NixOS/nixpkgs/nixos-23.05";

    # NixOS
    nixpkgs-for-nixos-cubby.url = "github:NixOS/nixpkgs/nixos-23.05";
    nixpkgs-for-nixos-renzo.url = "github:NixOS/nixpkgs/nixos-23.05";

    # Stable, general-purpose
    nixpkgs-from-stable-cubby.url = "github:NixOS/nixpkgs/nixos-23.05";
    nixpkgs-from-stable-renzo.url = "github:NixOS/nixpkgs/nixos-23.05";

    # Unstable, general-purpose
    nixpkgs-from-unstable-cubby.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-from-unstable-renzo.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = inputs:
    let
      system = "x86_64-linux";
      inherit (inputs."nixpkgs-for-lib".legacyPackages.x86_64-linux) lib;
      nixpkgsConfig = {
        inherit system;
        config.allowUnfree = true;
      };

      mkNixos = hostname:
        let
          nixpkgs.from = {
            stable =
              import inputs."nixpkgs-from-stable-${hostname}" nixpkgsConfig;
            unstable =
              import inputs."nixpkgs-from-unstable-${hostname}" nixpkgsConfig;
          };
        in
        inputs."nixpkgs-for-nixos-${hostname}".lib.nixosSystem {
          inherit system;
          specialArgs = { inherit nixpkgs inputs; };
          modules = let base = inputs.base.nixosModules.${system}; in [
            ./${hostname}
            base.authorized-keys
            base.essentials
            base.extra
            base.fonts
            base.location
            base.home
            base.networking
            base.nix
            base.printing
          ];
        };

    in
    {
      nixosConfigurations = {
        cubby = mkNixos "cubby";
        renzo = mkNixos "renzo";
      };
    };
}
