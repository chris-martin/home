{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.programs.cabal;
in
{
    imports = [];

    options = {
        programs.cabal = {
            enable = mkOption {
                type = types.bool;
                default = false;
                description = "If enabled, write Cabal config file.";
            };
            username = mkOption {
                type = types.nullOr types.str;
                default = null;
                description = "Hackage username";
            };
            passwordCommand = mkOption {
                type = types.nullOr types.str;
                default = null;
                description = "Executable that prints Hackage password";
            };
            installDirectory = mkOption {
                type = types.nullOr types.str;
                default = null;
                description = "Where 'cabal install' should put built executables";
            };
            jobs = mkOption {
                type = types.str;
                default = "$ncpus";
                description = "How many jobs to run in parallel";
            };
        };
    };

    config = mkIf cfg.enable (mkMerge [

        {
            home.file.".cabal/config".text = concatStrings [
                ''
                    repository hackage.haskell.org
                        url: https://hackage.haskell.org/
                ''
                (optionalString (cfg.username != null) ''
                    username: ${cfg.username}
                '')
                (optionalString (cfg.passwordCommand != null) ''
                    password-command: ${cfg.passwordCommand}
                '')
                (optionalString (cfg.installDirectory != null) ''
                    installdir: ${cfg.installDirectory}
                '')
                ''
                    jobs: ${cfg.jobs}
                ''
            ];
        }

    ]);
}
