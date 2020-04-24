{}:

(import (builtins.fetchTarball {
    url = "https://github.com/hercules-ci/ghcide-nix/tarball/1a95c1151fba41fc366f04732512fcaa561bff6c";
    sha256 = "0kp9kb2a8sfy5a50162vna3j0lv8g3s6lg9dszc13qhmr24kfjzl";
}) {}).ghcide-ghc865
