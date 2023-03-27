{
    inputs.nixpkgs.url = github:NixOS/nixpkgs;
    outputs = { self, nixpkgs }:
      let
          system = "x86_64-linux";
          pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
          inherit (pkgs) minecraft-server;
      in
          {
              nixosModule = import ./nixos-module.nix {
                  inherit minecraft-server;
              };
              defaultPackage.${system} = minecraft-server;
          };
}
