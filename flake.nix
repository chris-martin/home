{
  inputs = {

    # Nix library functions
    nixpkgs-for-lib.url = "github:NixOS/nixpkgs/nixos-22.11";

    # Home-manager
    home-manager-cubby.url = "github:nix-community/home-manager";
    home-manager-renzo.url = "github:nix-community/home-manager";

    # Firefox
    nixpkgs-for-firefox-cubby.url = "github:NixOS/nixpkgs/nixos-22.11";
    nixpkgs-for-firefox-renzo.url = "github:NixOS/nixpkgs/nixos-22.11";

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
    in {

      nixosConfigurations = {

        cubby = let
          home-manager = inputs.home-manager-cubby;
          nixpkgs.for = {
            firefox = import inputs.nixpkgs-for-firefox-cubby nixpkgsConfig;
            vscode = import inputs.nixpkgs-for-vscode-cubby nixpkgsConfig;
            hoogle = import inputs.nixpkgs-for-hoogle-cubby nixpkgsConfig;
          };
          nixpkgs.from = {
            stable = import inputs.nixpkgs-from-stable-cubby nixpkgsConfig;
            unstable = import inputs.nixpkgs-from-unstable-cubby nixpkgsConfig;
          };
        in inputs."nixpkgs-for-nixos-cubby".lib.nixosSystem {
          inherit system;
          specialArgs = { inherit home-manager; };
          modules = [
            ./nixos-modules/cubby
            inputs."home-manager-cubby".nixosModule
            {
              home-manager = {
                extraSpecialArgs = { inherit nixpkgs; };
                users.chris = {
                  imports = [ ./home-modules/chris.nix ];
                  programs.firefox.package = nixpkgs.for."firefox".firefox;
                  programs.vscode.package = nixpkgs.for."vscode".vscode;
                };
              };
              services.hoogle.haskellPackages =
                nixpkgs.for."hoogle".haskellPackages;
            }
          ];
        };

      };

    };
}
