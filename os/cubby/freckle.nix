{ nixpkgs, ... }:
{
  networking.extraHosts = ''
    127.0.0.1 localhost.com
    127.0.0.1 api.localhost.com
    127.0.0.1 assets.localhost.com
    127.0.0.1 classroom.localhost.com
    127.0.0.1 school.localhost.com
    127.0.0.1 student.localhost.com
    127.0.0.1 console.localhost.com
    127.0.0.1 faktory.localhost.com
    127.0.0.1 tts.localhost.com
    127.0.0.1 sso.localhost.com
  '';

  # So that docker can see the host
  networking.firewall.allowedTCPPorts = [ 3000 ];

  virtualisation.docker = {
    enable = true;
    package = nixpkgs.for.docker.docker;
  };
}
