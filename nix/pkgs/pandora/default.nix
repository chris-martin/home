{ pithos, stdenv, fetchurl }:

let

  # http://gnome-look.org/content/show.php?content=120117
  icon = fetchurl {
    url = "https://cn.pling.com/img/hive/content-pre1/120117-1.png";
    sha256 = "03qn91h96gyagj4xvi44484mdq0gmw7dr88fv52wfa3iphhy9lv1";
  };

in

    stdenv.mkDerivation rec {
      name = "pandora";

      src = ./.;

      phases = [ "installPhase" ];

      installPhase = ''
        x=$out/bin/pandora
        mkdir -p $(dirname $x)
        ln -vs ${pithos}/bin/pithos $x

        x=$out/share/applications/pandora.desktop
        mkdir -p $(dirname $x)
        cp -v $src/pandora.desktop $x

        x=$out/share/icons/hicolor/256x256/apps/pandora.png
        mkdir -p $(dirname $x)
        cp -v ${icon} $x
      '';

      meta = with stdenv.lib; {
        description = "Radio on the internet";
      };
    }
