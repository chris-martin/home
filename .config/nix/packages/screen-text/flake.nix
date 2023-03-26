{
  description = "Screen Text";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";

  outputs = { self, nixpkgs }: {

    defaultPackage.x86_64-linux =
      let
        pkgs = import nixpkgs { system = "x86_64-linux"; };
      in
        pkgs.writeShellScriptBin "screen-text" ''
            IMG=$(mktemp /tmp/screentext.XXXX.png)
            OUT_BASE=$(mktemp /tmp/screentext.XXXX)
            OUT="$OUT_BASE.txt"

            ${pkgs.gnome3.gnome-screenshot}/bin/gnome-screenshot -a -f $IMG &> /dev/null

            # scaling should increase detection rate
            ${pkgs.imagemagick7}/bin/mogrify -modulate 100,0 -resize 400% $IMG

            ${pkgs.tesseract}/bin/tesseract $IMG $OUT_BASE &> /dev/null

            cat $OUT | ${pkgs.xclip}/bin/xclip -selection clipboard
            cat $OUT

            rm $IMG
            rm $OUT
        '';

  };
}
