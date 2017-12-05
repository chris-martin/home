{ stdenv, lib, bundlerEnv, ruby, makeWrapper }:

let
  pname = "riemann-cli";

  version = (import ./gemset.nix).riemann-cli.version;

  env = bundlerEnv rec {
    name = "${pname}-env-${version}";
    inherit ruby;
    gemfile = ./Gemfile;
    lockfile = ./Gemfile.lock;
    gemset = ./gemset.nix;
  };

in stdenv.mkDerivation {
  name = "${pname}-${version}";

  phases = [ "installPhase" ];

  buildInputs = [ env makeWrapper ];

  installPhase = ''
    mkdir -p $out/bin
    makeWrapper ${env}/bin/riemann-cli $out/bin/riemann-cli
  '';

  meta = with lib; {
    description = "Simple command-line tool that sends events to Riemann or queries its index";
    homepage = https://github.com/paulgoldbaum/riemann-cli;
    license = with licenses; mit;
    maintainers = with maintainers; [ chris-martin ];
    platforms = platforms.unix;
  };
}
