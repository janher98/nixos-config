#
#  Terminal Emulator
#

{ pkgs, vars, ... }:

{
  home-manager.users.${vars.user} = {
    programs = {
      kitty = {
        enable = true;
        #theme = "Cattppuccin Latte";
        #theme = "Clrs";
        #theme = "Tango Light";
        settings = {
          confirm_os_window_close=0;
        };
      };
    };
  };
}
