{
    inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    outputs = { self, nixpkgs }:
      let
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        inherit (pkgs) haskellPackages;
        inherit (haskellPackages) ghcWithHoogle;
      in
        {
            nixosModule = import ./hoogle.nix { inherit haskellPackages; };
            defaultPackage.x86_64-linux = ghcWithHoogle (import ./packages.nix);
        };
}
