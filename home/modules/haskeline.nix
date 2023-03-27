{ config, lib, pkgs, ... }:
with lib;
let cfg = config.programs.haskeline;
in {
  imports = [ ];

  options = {
    programs.haskeline = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "If enabled, write Haskeline config file.";
      };
      history-duplicates = mkOption {
        type = types.enum [ "AlwaysAdd" "IgnoreConsecutive" "IgnoreAll" ];
        default = "AlwaysAdd";
        description =
          "How to record history when the same line is entered repeatedly";
      };
    };
  };

  config = mkIf cfg.enable (mkMerge [

    {
      home.file.".haskeline".text = concatStrings [''
        historyDuplicates: ${cfg.history-duplicates}
      ''];
    }

  ]);
}
