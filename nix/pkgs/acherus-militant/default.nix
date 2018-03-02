{ runCommand }:

runCommand "acherus-militant" { } ''
  d=$out/share/fonts/truetype
  mkdir --parents $d
  ln -s ${./acherus-militant-light.otf} --target-directory=$d
  ln -s ${./acherus-militant-bold.otf}  --target-directory=$d
''
