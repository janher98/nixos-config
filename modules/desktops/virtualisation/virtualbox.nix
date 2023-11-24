#
#  Podman
#

{ config, pkgs, vars, ... }:

{
  users.extraGroups.vboxusers.members = [ "${vars.user}" ];

#  environment.systemPackages = with pkgs; [
#    virtualbox
#  ];  
  
  virtualisation = {
    virtualbox = {
      host = {
        enable = true;
        enableExtensionPack = true;
      };
    };
  };
}