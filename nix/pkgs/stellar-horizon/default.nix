{ lib, buildGoPackage, fetchFromGitHub, fetchgit, fetchhg, tree }:

let
  pname = "stellar-horizon";
  version = "0.6.2";
  goPackagePath = "github.com/stellar/horizon";
  goDeps = ./deps.nix;
  goPath = importGodeps { depsFile = goDeps; };

  src = fetchFromGitHub {
    owner = "stellar";
    repo = "horizon";
    rev = "v${version}";
    sha256 = "01w505vb723irscf0jdfjlg2z7zrzpgkags7wcajy1mrh53ssgb0";
  };

  dep2src = goDep:
    {
      inherit (goDep) goPackagePath path;
      src = if goDep.fetch.type == "git" then
        fetchgit {
          inherit (goDep.fetch) url rev sha256;
        }
      else if goDep.fetch.type == "hg" then
        fetchhg {
          inherit (goDep.fetch) url rev sha256;
        }
      else abort "Unrecognized package fetch type";
    };

  importGodeps = { depsFile }:
    map dep2src (import depsFile);

  configurePhase = ''
    runHook preConfigure

    # Extract the source
    cd "$NIX_BUILD_TOP"
    mkdir -p go
    mv "$sourceRoot/src" go

  '' + lib.flip lib.concatMapStrings goPath ({ src, goPackagePath, path }: ''
    mkdir goPath
    (cd goPath; unpackFile "${src}")
    mkdir -p "go/src/$(dirname "${goPackagePath}")"
    chmod -R u+w goPath/*
    mv goPath/*${path} go/src/${goPackagePath}
    rm -r goPath

  '') + ''
    export GOPATH=$NIX_BUILD_TOP/go:$GOPATH

    runHook postConfigure
  '';

  buildPhase = ''
    runHook preBuild
    export GOBIN="$NIX_BUILD_TOP/go/bin"
    go install -v ${goPackagePath}/cmd/horizon
    runHook postBuild
  '';

in buildGoPackage {
  name = "${pname}-${version}";
  inherit goPackagePath goDeps src configurePhase buildPhase;
  buildInputs = [tree];
}
