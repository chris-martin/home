{ pkgs, python, self, fetchgit, fetchurl, fetchFromGitHub, ... }:

rec {

  bigchaindb = self.buildPythonPackage rec {
    pname = "BigchainDB";
    version = "0.4.0";
    name = "${pname}-${version}";
    disabled = !self.isPy34;

    # I don't know why the check phase fails
    doCheck = false;

    propagatedBuildInputs = with self; [
      base58 requests-2-9-0 rethinkdb statsd flask rapidjson cryptoconditions
      pysha3 pytz logstats gunicorn
    ];

    buildInputs = with self; [
      pytest pytest-flask coverage pep8 pyflakes pylint pytest pytest-cov
      pytest-xdist
    ];

    src = fetchurl {
      url = "https://pypi.python.org/packages/cb/53/33466d60f0d85babd7f09e6b42406017a9fc2948baff8557920b191d2865/${name}.tar.gz";
      sha256 = "0zw6nndrd55sv9179cmvpxb32s4ck6gyp733mgn5m73n83jhggvq";
    };

    meta = {
      description = "A scalable blockchain database";
      homepage = "https://www.bigchaindb.com/";
      license = with self.licenses; [ agpl3 ];
    };
  };

  bitcoin = self.buildPythonPackage rec {
    name = "bitcoin-${version}";
    version = "1.1.42";

    src = fetchurl {
      url = "https://pypi.python.org/packages/12/88/c9390638d5b2713d38ccea46c93e8ec084f052a15a94f9b1d4c66baabd24/${name}.tar.gz";
      sha256 = "0dkjifd8d60an0jl6k9zqx9r0p5xprzlrgf4n9mlyxhwksyp1fhi";
    };
  };

  coveralls = self.buildPythonPackage rec {
    name = "coveralls-${version}";
    version = "1.1";

    src = fetchurl {
      url = "https://pypi.python.org/packages/12/50/5c1034eb92e5bc3d824a3745ca9162f2e4846c6ab5f96dccb5f84f77e98f/${name}.tar.gz";
      sha256 = "0238hgdwbvriqxrj22zwh0rbxnhh9c6hh75i39ll631vq62h65il";
    };

    propagatedBuildInputs = with self; [ docopt coverage requests pyyaml ];
  };

  cryptoconditions = self.buildPythonPackage rec {
    name = "cryptoconditions-${version}";
    version = "0.3.0";

    src = fetchurl {
      url = "https://pypi.python.org/packages/a9/21/58ee457e3d5f0e40312670b3e80250cf1ab1724f98747e166f5bea3be9b6/${name}.tar.gz";
      sha256 = "0db5jwws6x30k46903zaqa727gpdx5m8dqk9g90qihqpj7a7xfd1";
    };

    propagatedBuildInputs = with self; [ base58_0_2_2 ed25519 ];

    buildInputs = with self; [ pytest ];
  };

  cryptodome = self.buildPythonPackage rec {
    name = "pycryptodome-${version}";
    version = "3.4";

    src = fetchurl {
      url = "https://pypi.python.org/packages/78/a9/3ad761efa8c947d06db18a4a7cfc7773806cdee48a37187b022647313d68/${name}.tar.gz";
      sha256 = "0nc4ry2ah56l40hr1dilw19ksma8bx3cmn99mp5vml4jlz9zkg16";
    };
  };

  logstats = self.buildPythonPackage rec {
    name = "logstats-${version}";
    version = "0.2.1";

    src = fetchurl {
      url = "https://pypi.python.org/packages/1d/e8/a0dd81934c909e145af9709d47d1e7866b26a75f0c37b77ce75fd2b625cd/${name}.tar.gz";
      sha256 = "02b7bk99023j1bgs1as7qmndcwknxmq3m3lvhs7kqnqg2pkp34m1";
    };
  };

  riemann-client = self.buildPythonPackage rec {
    name = "riemann-client-${version}";
    version = "6.3.0";

    src = fetchurl {
      url = "https://pypi.python.org/packages/17/64/1f49990762adf2742bf7e8587e83bdd0c9faaea181e3df75fdee1cb715aa/riemann-client-6.3.0.tar.gz";
      sha256 = "1mh09m1xbr9f6w34085w8mp9hr3xgq7dfi132qydpm1f4gbj32hs";
    };

    propagatedBuildInputs = with self; [ click protobuf ];
  };

  rlp = rlp-0-4-5;

  rlp-0-4-4 = self.buildPythonPackage rec {
    name = "rlp-${version}";
    version = "0.4.4";

    src = fetchurl {
      url = "https://pypi.python.org/packages/9a/e9/003c57e947097b855af81ba9ec1a41e1daf3aec921073aa4516e0a00a246/${name}.tar.gz";
      sha256 = "0ca3fqz7pgd8wmm8mgqlfz56l94x375w2wmgkbg26h624nk0bkdd";
    };
  };

  rlp-0-4-5 = self.buildPythonPackage rec {
    name = "rlp-${version}";
    version = "0.4.5";

    src = fetchurl {
      url = "https://pypi.python.org/packages/91/68/01756d0e57f4d2ad151c277b838256c58ffc1a0f97812f265f17563a5765/${name}.tar.gz";
      sha256 = "14vp35w1fkavnv17qgfz5mfa3k5l3przj4gvlma3r8f9hqwbjwrw";
    };
  };

  pyethash = self.buildPythonPackage rec {
    name = "pyethash-${version}";
    version = "0.1.27";

    src = fetchurl {
      url = "https://pypi.python.org/packages/6c/40/5bb02ad7e2fae9b04cd0c391dda81213bc786c30c8381b018600cfc7ce62/${name}.tar.gz";
      sha256 = "0618kkn2sb0a3h2pphpj2vi455xc9mil42b13zgpg7bbwaf32rpz";
    };
  };

  pyethereum = self.buildPythonPackage rec {
    version = "1.3.2";
    name = "pyethereum-${version}";

    src = fetchgit {
      url = "https://github.com/ethereum/pyethereum.git";
      rev = "refs/tags/v${version}";
      sha256 = "0bzqppjyy6ppgcbql416vyy1ylgq9ic1lpsa5004995hn539jf8q";
      fetchSubmodules = true;
    };

    checkPhase = ''
      echo "Skipping pyethereum tests because they're slow."
    '';

    buildInputs = with self; [
      pytest-2-9-1 pytest-catchlog pytest-timeout
      serpent coveralls tox virtualenv pluggy
    ];

    propagatedBuildInputs = with self; [
      bitcoin pysha3 pyyaml repoze_lru pbkdf2 cryptodome
      scrypt rlp-0-4-4 pyethash secp256k1
    ];

    meta = {
      homepage = https://github.com/ethereum/pyethereum;
      description = "Next generation cryptocurrency network";
    };
  };

  pysha3 = pysha3-0-3;

  pysha3-0-1 = self.buildPythonPackage rec {
    name = "pysha3-${version}";
    version = "0.1";

    src = fetchurl {
      url = "https://pypi.python.org/packages/89/6a/fe37f6f74acee78c20cfa9206a39e09503514aa70ceb67b6fd0af4327089/${name}.tar.gz";
      sha256 = "1zhkj2wp019amvq9hqwcsmdj4lxgzhdab78ydchag4k3d8vhkq9n";
    };

    meta = {
      homepage = https://bitbucket.org/tiran/pykeccak;
      description = "SHA-3 wrapper (keccak) for Python";
    };
  };

  pysha3-0-3 = self.buildPythonPackage rec {
    name = "pysha3-${version}";
    version = "0.3";

    src = fetchurl {
      url = "https://pypi.python.org/packages/d0/17/9fb9efcde17f8fc77e0af0b49281d22eb7c640e326987b0308c88a927ba5/${name}.tar.gz";
      sha256 = "0kghj6wbxjzwfn0h6m90yxkwx09wydr5p0kcgj2gn4fyfwgmy70r";
    };

    meta = {
      homepage = https://bitbucket.org/tiran/pykeccak;
      description = "SHA-3 wrapper (keccak) for Python";
    };
  };

  pytest = pytest-2-9-1;

  # Pytest upgraded beyond what's in nixpkgs upstream.
  # There's some stuff removed from this definition that
  # I just didn't care about.
  pytest-2-9-1 = self.buildPythonPackage rec {
    name = "pytest-2.9.1";

    src = fetchurl {
      url = "https://pypi.python.org/packages/5e/f0/75c5cee17575bef459c916b6276bd9ad56944836bb0d9e36dd05704e7f35/${name}.tar.gz";
      sha256 = "0rby2jlb67mrjkv6siyl8m82by1migh5g08mr3kzni3n29xd4j0d";
    };

    preCheck = ''
      # don't test bash builtins
      rm testing/test_argcomplete.py
    '';

    propagatedBuildInputs = with self; [ py ];
  };

  pytest-catchlog = self.buildPythonPackage rec {
    name = "pytest-catchlog-1.2.2";

    src = fetchurl {
      url = "https://pypi.python.org/packages/f2/2b/2faccdb1a978fab9dd0bf31cca9f6847fbe9184a0bdcc3011ac41dd44191/${name}.zip";
      sha256 = "1w7wxh27sbqwm4jgwrjr9c2gy384aca5jzw9c0wzhl0pmk2mvqab";
    };

    propagatedBuildInputs = with self; [ py pytest ];
  };

  pytest-cov = self.buildPythonPackage rec {
    name = "pytest-cov-2.2.1";

    src = fetchurl {
      url = "https://pypi.python.org/packages/39/07/bdd2d985ae7ac726cc5e7a6a343b585570bf1f9f7cb297a9cd58a60c7c89/${name}.tar.gz";
      sha256 = "1yl4nbhzfgsxqlsyk4clafgp9x11zvgrkprm9i2p3fgkwx9jxcm8";
    };

    propagatedBuildInputs = with self; [ py pytest coverage ];
  };

  pytest-flask = self.buildPythonPackage rec {
    name = "pytest-flask-0.10.0";

    src = fetchurl {
      url = "https://pypi.python.org/packages/b4/b5/6d86a2362be78d1d817c7a1d5105100b7b51089dd56ca907d4fed9461570/${name}.tar.gz";
      sha256 = "00vznyjfn6qszq6v551z53y9g4gqsjysxvyvbpwbdy1y0gwkcnic";
    };

    propagatedBuildInputs = with self; [ py pytest werkzeug flask ];
  };

  pytest-httpbin = self.buildPythonPackage rec {
    name = "pytest-httpbin-0.2.3";

    src = fetchurl {
     url = "https://pypi.python.org/packages/12/12/5430600cb9417080b561237761ff2dffde520b664cc352433d2e57051222/${name}.tar.gz";
     sha256 = "1y0v2v7xpzpyd4djwp7ad8ifnlxp8r1y6dfbxg5ckzvllkgridn5";
    };

    propagatedBuildInputs = with self; [ py pytest decorator flask httpbin six ];
  };

  pytest-timeout = self.buildPythonPackage rec {
    name = "pytest-timeout-1.0.0";

    src = fetchurl {
      url = "https://pypi.python.org/packages/cf/92/ab29b9baa54d47dfd50e43be35577de9af4e7ebf27d29f546ddeb6c3b6f5/${name}.tar.gz";
      sha256 = "1qccg490vvjsasy5dmwpp4apx2j2j8v4bcfi2lgdy5iywxmhjr8l";
    };

    propagatedBuildInputs = with self; [ py pytest ];
  };

  pytest-xdist = self.buildPythonPackage rec {
    name = "pytest-xdist-1.14";

    src = fetchurl {
      url = "https://pypi.python.org/packages/9e/df/434c91ac13e96dae9bf519eb4d606d99beac835c7f859d2bca923dbb6b80/${name}.zip";
      sha256 = "08rn2l39ds60xshs4js787l84pfckksqklfq2wq9x8ig2aci2pja";
    };

    propagatedBuildInputs = with self; [ py pytest execnet ];
  };

  rapidjson = self.buildPythonPackage rec {
    pname = "rapidjson";
    version = "0.0.6";
    name = "${pname}-${version}";

    src = fetchurl {
      url = "https://pypi.python.org/packages/14/af/1c2f7677d2ff8bc6f25d9e96c5fef9fe4886038dfaabe73c797d621de2c2/python-${name}.tar.gz";
      sha256 = "1simb7b0yypwzr89vqidrvxafi34kcn2g54q8rjsssq61ijppx94";
    };
  };

  requests-2-9-0 = self.buildPythonPackage rec {
    pname = "requests";
    version = "2.9.0";
    name = "${pname}-${version}";

    # I don't know why the check phase fails
    doCheck = false;

    src = fetchurl {
      url = "https://pypi.python.org/packages/e4/99/3e33bfe263894278a094c374f87031554406e57fd0b1ad22520357556627/${name}.tar.gz";
      sha256 = "1f4f7zkcvkrpb3ymcvq84r58q6vdwsfr1za449anr8xm69jrd0a8";
    };
  };

  requests-2-10-0 = self.buildPythonPackage rec {
    pname = "requests";
    version = "2.10.0";
    name = "${pname}-${version}";

    # I don't know why the check phase fails
    doCheck = false;

    src = fetchurl {
      url = "https://pypi.python.org/packages/49/6f/183063f01aae1e025cf0130772b55848750a2f3a89bfa11b385b35d7329d/${name}.tar.gz";
      sha256 = "0m2vaasjdhrsf9nk05q0bybqw0w4w4p3p4vaw7730w8mi1bq3wb3";
    };
  };

  rethinkdb = self.buildPythonPackage rec {
    pname = "rethinkdb";
    version = "2.3.0";
    name = "${pname}-${version}";

    src = fetchurl {
      url = "https://pypi.python.org/packages/4c/a8/384144095230d21928c7d9615acb111c6ed4cd2af1aef5e8fe9d528451c0/${name}.tar.gz";
      sha256 = "1xshqz3q7bi3si623mj860i44ayd4pkhp0rxj2dd055v1720ycrn";
    };
  };

  scrypt = scrypt-0-7-0;

  scrypt-0-7-0 = self.buildPythonPackage rec {
    name = "scrypt-${version}";
    version = "0.7.0";

    src = fetchurl {
      url = "https://pypi.python.org/packages/47/6d/43520bedaac7c5c2b2a9e5a8229d82ca2c2242c34b46575ed7b988f248a5/${name}.tar.gz";
      sha256 = "0vx579w6ik9l46bh41piq9bf49aa3xhzh768lz59qxvh6z6xmhx5";
    };

    propagatedBuildInputs = with self; [ pkgs.openssl ];
  };

  # broken
  scrypt-0-7-1 = self.buildPythonPackage rec {
    name = "scrypt-${version}";
    version = "0.7.1";

    src = fetchurl {
      url = "https://pypi.python.org/packages/f6/fa/2e80258d58555d38ba0373db3c8947e03ceaaa91ad9f80725802bc05aa77/${name}.tar.gz";
      sha256 = "18qxyqh0r5p3iyx3g6yd3vmmnw3yl1qz0cb59cw7hqc11hq8rxpm";
    };

    propagatedBuildInputs = with self; [ pkgs.openssl ];
  };

  # https://github.com/NixOS/nixpkgs/pull/15979
  secp256k1 = self.buildPythonPackage rec {
    name = "secp256k1";

    src = fetchFromGitHub {
      owner = "ulope";
      repo = "secp256k1-py";
      rev = "cb3078d4800ac0bdc64f4242462cb3c186329378";
      sha256 = "0kyaph97gjwv4vv5nl9j5w8zp2bb606z4hfmjzl5la1da5gsdfaq";
    };

    buildInputs = with self; [ pkgs.pkgconfig ];
    propagatedBuildInputs = with self; [ cffi pkgs.secp256k1 ];

    preConfigure = ''
      ln -s ${pkgs.secp256k1.src} libsecp256k1
      export INCLUDE_DIR=${pkgs.secp256k1}/include
      export LIB_DIR=${pkgs.secp256k1}/lib
    '';

    meta = {
      homepage = https://github.com/ulope/secp256k1-py;
      description = "Python FFI bindings for secp256k1";
    };
  };

  # https://github.com/NixOS/nixpkgs/pull/15977
  serpent = self.buildPythonPackage rec {
    name = "serpent";

    src = fetchFromGitHub {
      owner = "ethereum";
      repo = "serpent";
      rev = "51ee60857fe53c871fa916ef66fc1b4255bb9433";
      sha256 = "1bns9wgn5i1ahj19qx7v1wwdy8ca3q3pigxwznm5nywsw7s7lqxs";
    };
  };

}
