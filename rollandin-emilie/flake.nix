{
  description = "RollandinEmilie";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
  outputs = { self, nixpkgs }: {
    defaultPackage.x86_64-linux =
      let pkgs = import nixpkgs { system = "x86_64-linux"; };
      in pkgs.runCommand "rollandin-emilie" { } ''
        d=$out/share/fonts/truetype
        mkdir --parents $d
        ln -s ${./RollandinEmilie.ttf} --target-directory=$d
      '';
  };
}
