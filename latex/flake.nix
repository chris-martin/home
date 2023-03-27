{
  description = "LaTeX";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";

  outputs = { self, nixpkgs }: {

    defaultPackage.x86_64-linux =
      let pkgs = import nixpkgs { system = "x86_64-linux"; };
      in pkgs.texlive.combine {
        inherit (pkgs.texlive)

          adjustbox collectbox framed leaflet merriweather scheme-medium xetex

        ;
      };

  };
}
