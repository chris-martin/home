{ mkDerivation, attoparsec, base, bytestring, cassava, containers
, doctest, foldl, hedgehog, pipes, pipes-bytestring, pipes-safe
, safe-exceptions, stdenv, template-haskell, text, validation
, vector
}:
mkDerivation {
  pname = "dsv";
  version = "1.0.0.0";
  sha256 = "f6052004fef544155daf8a238d28545867ee3b539a265c3b3f3e2a8791ba4e3a";
  enableSeparateDataOutput = true;
  libraryHaskellDepends = [
    attoparsec base bytestring cassava containers foldl pipes
    pipes-bytestring pipes-safe template-haskell text validation vector
  ];
  testHaskellDepends = [
    base bytestring containers doctest foldl hedgehog safe-exceptions
    text vector
  ];
  homepage = "https://github.com/typeclasses/dsv";
  description = "DSV (delimiter-separated values)";
  license = stdenv.lib.licenses.mit;
}
