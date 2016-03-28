{ stdenv, callPackage, fetchurl, makeDesktopItem, makeWrapper, patchelf
, coreutils, gnugrep, which, git, python, unzip, p7zip
, androidsdk, jdk
}:

assert stdenv.isLinux;

let

  bnumber = with stdenv.lib; build: last (splitString "-" build);
  mkIdeaProduct = callPackage ./common.nix { };

  buildIdea = { name, version, build, src, license, description }:
    (mkIdeaProduct rec {
      inherit name version build src;
      product = "IDEA";
      meta = with stdenv.lib; {
        homepage = "https://www.jetbrains.com/idea/";
        inherit description license;
        longDescription = ''
          IDE for Java SE, Groovy & Scala development Powerful
          environment for building Google Android apps Integration
          with JUnit, TestNG, popular SCMs, Ant & Maven.
        '';
        maintainers = with maintainers; [ edwtjo ];
        platforms = platforms.linux;
      };
    });

in

{

  idea15-ultimate = buildIdea rec {
    name = "idea-ultimate-${version}";
    version = "15.0.4";
    build = "IU-143.2287";
    description = "Integrated Development Environment (IDE) by Jetbrains, requires paid license";
    license = stdenv.lib.licenses.unfree;
    src = fetchurl {
      url = "https://download.jetbrains.com/idea/ideaIU-${version}.tar.gz";
      sha256 = "0416y7krrak1q5pb8axskdamy06nfxmn4hj7421j8jaz0nc50dn4";
    };
  };

}
