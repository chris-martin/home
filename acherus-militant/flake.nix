{
  description = "Acherus Militant";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
  outputs = { self, nixpkgs }: {
    defaultPackage.x86_64-linux =
      let pkgs = import nixpkgs { system = "x86_64-linux"; };
      in pkgs.runCommand "acherus-militant" { } ''
        d=$out/share/fonts/truetype
        mkdir --parents $d
        ln -s ${./acherus-militant-light.otf} --target-directory=$d
        ln -s ${./acherus-militant-bold.otf}  --target-directory=$d
      '';
  };
}
