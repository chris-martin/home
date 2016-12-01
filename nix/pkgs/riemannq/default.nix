{ stdenv, buildGoPackage, fetchFromGitHub }:

buildGoPackage rec {
  name = "$riemannq-${version}";
  version = "2013-11-05";

  src = fetchFromGitHub {
    owner = "rasputnik";
    repo = "riemannq";
    rev = "0535cbc59c604fcbae09694b215825d36e9ee82e";
    sha256 = "02c3z5dd70v1ggm9sww7bz3xqgjf5amwm88q3bizqwckv9imd086";
  };

  goPackagePath = "github.com/rasputnik/riemannq";
  goDeps = ./deps.nix;

  meta = with stdenv.lib; {
    inherit (src.meta) homepage;
    description = "Simple Riemann query tool";
    license = with licenses; [ unfree ]; # https://github.com/rasputnik/riemannq/issues/2
    maintainers = with maintainers; [ chris-martin ];
    platforms = with platforms; linux;
  };
}
