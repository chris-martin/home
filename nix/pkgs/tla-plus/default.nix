{ callPackage, buildEnv, ... }:

let

  core = execName: javaMain: callPackage ./core.nix {
    execName = execName;
    javaMain = javaMain;
  };

in

rec {

  tlc = core "tlc" "tlc2.TLC";

  sany = core "sany" "tla2sany.SANY";

  pluscal = core "pluscal" "pcal.trans";

  tlatex = core "tlatex" "tla2tex.TLA";

  tlaps = callPackage ./tlaps.nix {};

  toolbox = callPackage ./toolbox.nix {};

  all = buildEnv {
    name = "tlaplus";
    paths = [ tlc sany pluscal tlatex tlaps toolbox ];
  };

}
