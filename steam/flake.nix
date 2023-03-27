{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      inherit (pkgs) steam;
    in {
      nixosModule = import ./nixos-module.nix { inherit steam; };
      defaultPackage.${system} = steam;
    };
}
