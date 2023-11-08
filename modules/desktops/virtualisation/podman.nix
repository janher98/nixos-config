#
#  Podman
#

{ config, unstable, vars, ... }:

{
  users.groups.docker.members = [ "${vars.user}" ];

  environment.systemPackages = with unstable; [
    podman-compose
    distrobox
  ];

  virtualisation = {
    podman = {
      enable = true;
      #rootless = {
       # enable = true;
       # setSocketVariable = true;
      #};
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
    oci-containers = {
      backend = "podman";
#      containers = {
#        container-name = {
#          image = "stuff";
#          autostart = true;
#          ports = [ "127.0.0.1:1234:1234"];
#        };
#      };
    };
  };
}