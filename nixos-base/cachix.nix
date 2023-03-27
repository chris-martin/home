{ pkgs, ... }:
let
  src = pkgs.fetchFromGitHub {
    owner = "cachix";
    repo = "cachix";

    # Jun 23, 2018
    rev = "6a65632a4b51488b5355377e5c292a6a01efee2e";
    sha256 = "13l12xkqpx6l7pfqwysz6yrgpjk6ydj6w7c85h74mzz4fvzihxyl";
  };

  cachix = pkgs.callPackage src { };

in { environment.systemPackages = [ cachix ]; }
