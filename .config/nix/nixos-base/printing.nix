{ config, pkgs, ... }:

{
    services.printing = {
        enable = true;
        drivers = [ pkgs.brlaser pkgs.brgenml1lpr pkgs.brgenml1cupswrapper ];
    };
}
