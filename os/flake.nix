{
  inputs = {
    # Nix library functions
    nixpkgs-for-lib.url = "github:NixOS/nixpkgs/nixos-23.05";

    # Home-manager
    home-manager-cubby.url = "github:nix-community/home-manager/release-23.05";
    home-manager-renzo.url = "github:nix-community/home-manager/release-23.05";

    # NixOS
    nixpkgs-for-nixos-cubby.url = "github:NixOS/nixpkgs/nixos-23.05";
    nixpkgs-for-nixos-renzo.url = "github:NixOS/nixpkgs/nixos-23.05";

    # Stable, general-purpose
    nixpkgs-from-stable-cubby.url = "github:NixOS/nixpkgs/nixos-23.05";
    nixpkgs-from-stable-renzo.url = "github:NixOS/nixpkgs/nixos-23.05";

    # Unstable, general-purpose
    nixpkgs-from-unstable-cubby.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-from-unstable-renzo.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Docker
    nixpkgs-for-docker.url = "github:NixOS/nixpkgs/nixos-22.11";
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
          home-manager = inputs."home-manager-${hostname}";
          nixpkgs.for = {
            docker =
              import inputs."nixpkgs-for-docker" nixpkgsConfig;
          };
          nixpkgs.from = {
            stable =
              import inputs."nixpkgs-from-stable-${hostname}" nixpkgsConfig;
            unstable =
              import inputs."nixpkgs-from-unstable-${hostname}" nixpkgsConfig;
          };
        in
        inputs."nixpkgs-for-nixos-${hostname}".lib.nixosSystem {
          inherit system;
          specialArgs = { inherit home-manager nixpkgs; };
          modules = [
            ./${hostname}
            home-manager.nixosModule
            {
              home-manager = {
                extraSpecialArgs = { inherit nixpkgs; };
                users.chris.imports = [ ./home ];
              };
            }
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
