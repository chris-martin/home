{
  services.minecraft-server = {
    eula = true;
    openFirewall = true;
    declarative = true;
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
