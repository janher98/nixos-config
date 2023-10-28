{ config, pkgs, ... }:

{
  home.username = "jan";
  home.homeDirectory = "/home/jan";

  home.stateVersion = "22.05";
  programs.home-manager.enable = true;
 
  home.packages = with pkgs; [ thunderbird ];
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      james-yu.latex-workshop
    ];
  };

  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4";
      # Use kitty as default terminal
      terminal = "kitty"; 
      startup = [
        # Launch Firefox on start
        {command = "firefox";}
      ];
    };
  };
#  dconf.settings = {
#    "org/virt-manager/virt-manager/connections" = {
#      autoconnect = ["qemu:///system"];
#      uris = ["qemu:///system"];
#    };
#  };
}
