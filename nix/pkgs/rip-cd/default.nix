{ writeShellScriptBin, abcde }:

writeShellScriptBin "rip-cd" ''
  abcde -a cddb,read,encode,tag,move,playlist,clean -d /dev/cdrom -o ogg -V
''
