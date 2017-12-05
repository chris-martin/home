{ lib, stdenv, fetchFromGitHub, makeWrapper
, python3, texlive, imagemagick, ghostscript
}:

let
  name = "slack-latex-2017-08-16";

  meta = {
    description = "Slack bot for rendering LaTeX formulas";
    homepage = https://github.com/chris-martin/slacklatex;
  };

  src = fetchFromGitHub {
    owner = "chris-martin";
    repo = "slacklatex";
    rev = "77ddf178b394be6be7a0cfab12cb5973ee9f592b";
    sha256 = "0i7am3ykfl3qrq7ymgnhd00mbrzdbalc5swl68yw3rn2vp602mhp";
  };

  deps = [ python-env latex imagemagick ghostscript ];

  python-env = python3.withPackages (p: with p; [ flask requests ]);

  latex = texlive.combine {
    inherit (texlive)
      scheme-basic jknapltx amsmath standalone xkeyval preview rsfs metafont;
  };

  buildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -p "$out/bin"
    cp "$src/template.tex" "$out/template.tex"
    cp "$src/main.py" "$out/bin/slack-latex"
    wrapProgram "$out/bin/slack-latex" \
      --prefix PATH : "${lib.makeBinPath deps}" \
      --add-flags "--template-file $out/template.tex"
  '';

in

  stdenv.mkDerivation {
    inherit name src meta buildInputs installPhase;
  }
