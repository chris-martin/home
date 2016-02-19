{ config, pkgs }: {

  description = "Emacs Daemon";

  environment = {
    GTK_DATA_PREFIX = config.system.path;
    SSH_AUTH_SOCK   = "%t/ssh-agent";
    GTK_PATH        = "${config.system.path}/lib/gtk-3.0:${config.system.path}/lib/gtk-2.0";
    NIX_PROFILES    = "${pkgs.lib.concatStringsSep " " config.environment.profiles}";
    TERMINFO_DIRS   = "/run/current-system/sw/share/terminfo";
    ASPELL_CONF     = "dict-dir /run/current-system/sw/lib/aspell";
  };

  serviceConfig = {
    Type      = "forking";
    ExecStart = "${pkgs.bash}/bin/bash -c 'source ${config.system.build.setEnvironment}; emacs --daemon --no-desktop'";
    ExecStop  = "${pkgs.emacs}/bin/emacsclient --eval '(kill-emacs)'";
    Restart   = "always";
  };

  wantedBy = [ "default.target" ];
}
