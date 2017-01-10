{ stdenv, lib, go, fetchFromGitHub }:

let
  pname = "chain-core";
  version = "1.0.2";
  rev = "cmd.cored-${version}";
  goPackagePath = "github.com/chain/chain";

in stdenv.mkDerivation {
  name = "chain-core-${version}";
  inherit rev goPackagePath;

  buildInputs = [ go ];

  src = fetchFromGitHub {
    inherit rev;
    owner = "chain";
    repo = "chain";
    sha256 = "0q32vldz1333fq9j5dkzwq3782kyb57l78kavslg8h798qydfhxw";
  };

  configurePhase = ''
    export GOPATH=$NIX_BUILD_TOP/go:$GOPATH
    export CHAIN=$NIX_BUILD_TOP/go/src/chain
    export GOBIN=$NIX_BUILD_TOP/go/bin
    mkdir -p $NIX_BUILD_TOP/go/src
    mkdir -p $GOBIN
    mv $NIX_BUILD_TOP/$sourceRoot $CHAIN
  '';

  buildPhase = ''
    cd $CHAIN
    go install ./cmd/...
  '';

  installPhase = ''
    mkdir -p $out
    mv $GOBIN $out/bin
  '';

  meta = {
    homepage = https://chain.com/docs/core/get-started/introduction;
    description = "Operate and participate in permissioned blockchain networks";
    longDescription = ''
      Chain Core is software designed to operate and participate in permissioned
      blockchain networks. Each network maintains a cryptographically-secured
      multi-asset shared ledger. Using this ledger, participants can issue
      digital assets directly to custodians, who can then transfer them to each
      other in real time with no transactional intermediary. Each Chain Core
      holds a copy of the ledger and independently validates each update. A
      federation of block signers ensures global consistency of the ledger.
    '';
    license = lib.licenses.agpl3;
  };
}
