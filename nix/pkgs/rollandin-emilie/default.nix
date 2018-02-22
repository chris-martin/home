{ runCommand }:

runCommand "RollandinEmilie" { } ''
  d=$out/share/fonts/truetype
  mkdir --parents $d
  ln -s ${./RollandinEmilie.ttf} --target-directory=$d
''
