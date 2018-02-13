{ mkDerivation, aeson, ansi-wl-pprint, base, bifunctors, bytestring
, comonad, directory, fetchgit, filepath, free, lens, mtl
, optparse-applicative, parsers, scientific, semigroups, stdenv
, tasty, tasty-golden, text, text-format, text-manipulate, trifecta
, unordered-containers, vector
}:
mkDerivation {
  pname = "ede";
  version = "0.2.8.6";
  src = fetchgit {
    url = "https://github.com/chris-martin/ede.git";
    sha256 = "0sn5ijmg3s253iiqj2a7pizhgmdbf42gfmwjqgb9407hq396i932";
    rev = "7a0690429fe910b159e790a69e87b1f8a25accbf";
  };
  isLibrary = true;
  isExecutable = true;
  enableSeparateDataOutput = true;
  libraryHaskellDepends = [
    aeson ansi-wl-pprint base bifunctors bytestring comonad directory
    filepath free lens mtl parsers scientific semigroups text
    text-format text-manipulate trifecta unordered-containers vector
  ];
  executableHaskellDepends = [
    aeson base bytestring optparse-applicative text
  ];
  testHaskellDepends = [
    aeson base bifunctors bytestring directory tasty tasty-golden text
  ];
  homepage = "http://github.com/brendanhay/ede";
  description = "Templating language with similar syntax and features to Liquid or Jinja2";
  license = "unknown";
}
