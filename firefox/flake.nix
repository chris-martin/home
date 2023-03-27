{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      firefox = pkgs.firefox.override { cfg.enableGnomeExtensions = true; };
    in {
      homeModule = import ./home-module.nix { inherit firefox; };
      defaultPackage.${system} = firefox;
    };
}
