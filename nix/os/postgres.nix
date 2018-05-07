{ pkgs, ... }:
{
  services.postgresql.enable = false;
  services.postgresql.package = pkgs.postgresql94;
  services.postgresql.authentication = "local all all ident";
}
