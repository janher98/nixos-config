{config, pkgs, inputs,  ...}:
{
  nixpkgs.overlays = [inputs.nix-minecraft.overlay];
  services.minecraft-servers = {
    enable = true;
    eula = true;
    dataDir = "/persist/minecraft";
    servers = {
      creative-lea = {
        enable = false;
        openFirewall = true;
        serverProperties = {
          server-port = 25565;
          player-idle-timeout = 30;
          level-type = "minecraft:flat";
          default-player-permission-level = "operator";
          gamemode = "creative";
          difficulty = "peaceful";
          op-permission-level=4;
          enable-rcon = true;
          "rcon.password" = "asd";
          "rcon.port" = 25575;
          enable-command-block = true;
          #level-name = "guess-the-build-map";
        };

      };
      guess-the-build = {
        enable = true;
        openFirewall = true;
        serverProperties = {
          server-port = 25585;
          player-idle-timeout = 30;
          #level-type = "minecraft:flat";
          default-player-permission-level = "operator";
          gamemode = "creative";
          difficulty = "peaceful";
          op-permission-level=4;
          enable-rcon = true;
          "rcon.password" = "asd";
          "rcon.port" = 25595;
          enable-command-block = true;
        };

      };
    };
    #package = pkgs.minecraft-server_1_21_3;

  };
}
