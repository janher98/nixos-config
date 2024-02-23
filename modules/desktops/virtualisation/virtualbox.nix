#
#  Podman
#

{ config, pkgs, vars, lib, ... }:

with lib;
{
  options = {
    virtualbox = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };

  config = mkIf (config.virtualbox.enable) {
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
  };
}
