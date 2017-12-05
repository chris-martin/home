{ buildGoPackage, fetchFromGitHub }:

let
  pname = "fullwidth";
  version = "2017-02-13";

in buildGoPackage {
  name = "${pname}-${version}";

  goPackagePath = "github.com/agocs/fullwidth";

  src = fetchFromGitHub {
    owner = "agocs";
    repo = "fullwidth";
    rev = "62e9a23a8b60993f8691c5cde488494e965b5a50";
    sha256 = "05pzp3imk5a59jdn4arg2kpinwfb3r2r5gqxxabxpsbyg9kxjz8f";
  };

  goDeps = ./deps.nix;
}
