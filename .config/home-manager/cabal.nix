{ pkgs, ... }:
{
    programs.cabal = {
        enable = true;
        installDirectory = "/home/chris/.cabal/bin";
        username = "chris_martin";
        passwordCommand = "${pkgs.writeShellScript "print-hackage-password" ''
            ${pkgs.pass}/bin/pass show computer/haskell/hackage | ${pkgs.coreutils}/bin/head -n1
        ''}";
    };
}
