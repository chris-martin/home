{ minecraft-server }: {
  services.minecraft-server = {
    eula = true;
    openFirewall = true;
    declarative = true;
    package = minecraft-server;
    serverProperties = {
      server-port = 43000;
      gamemode = "survival";
      motd = "Moronuki house Minecraft";
      enable-rcon = false;
      white-list = false;
      difficulty = "easy";
      online-mode = false;
    };
  };
}
