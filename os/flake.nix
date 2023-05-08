{
  inputs = {
    # Nix library functions
    nixpkgs-for-lib.url = "github:NixOS/nixpkgs/nixos-22.11";

    # Home-manager
    home-manager-cubby.url = "github:nix-community/home-manager/release-22.11";
    home-manager-renzo.url = "github:nix-community/home-manager";

    # Hoogle
    nixpkgs-for-hoogle-cubby.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-for-hoogle-renzo.url = "github:NixOS/nixpkgs/nixos-unstable";

    # NixOS
    nixpkgs-for-nixos-cubby.url = "github:NixOS/nixpkgs/nixos-22.11";
    nixpkgs-for-nixos-renzo.url = "github:NixOS/nixpkgs/nixos-22.11";

    # VSCode
    nixpkgs-for-vscode-cubby.url = "github:NixOS/nixpkgs/nixos-22.11";
    nixpkgs-for-vscode-renzo.url = "github:NixOS/nixpkgs/nixos-22.11";

    # Stable, general-purpose
    nixpkgs-from-stable-cubby.url = "github:NixOS/nixpkgs/nixos-22.11";
    nixpkgs-from-stable-renzo.url = "github:NixOS/nixpkgs/nixos-22.11";

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
          home-manager = inputs."home-manager-${hostname}";
          nixpkgs.for = {
            vscode =
              import inputs."nixpkgs-for-vscode-${hostname}" nixpkgsConfig;
            hoogle =
              import inputs."nixpkgs-for-hoogle-${hostname}" nixpkgsConfig;
          };
          nixpkgs.from = {
            stable =
              import inputs."nixpkgs-from-stable-${hostname}" nixpkgsConfig;
            unstable =
              import inputs."nixpkgs-from-unstable-${hostname}" nixpkgsConfig;
          };
        in inputs."nixpkgs-for-nixos-${hostname}".lib.nixosSystem {
          inherit system;
          specialArgs = { inherit home-manager; };
          modules = [
            ./${hostname}
            home-manager.nixosModule
            {
              home-manager = {
                extraSpecialArgs = { inherit nixpkgs; };
                users.chris.imports = [ ./home ];
              };
              services.hoogle.haskellPackages =
                nixpkgs.for."hoogle".haskellPackages;
            }
          ];
        };

    in {
      nixosConfigurations = {
        cubby = mkNixos "cubby";
        renzo = mkNixos "renzo";
      };
    };
}
