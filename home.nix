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

#  wayland.windowManager.sway = {
#    enable = true;
#    config = rec {
#      modifier = "Mod4";
#      # Use kitty as default terminal
#      terminal = "kitty"; 
#      startup = [
#        # Launch Firefox on start
#        {command = "firefox";}
#      ];
#    };
#  };

#  dconf.settings = {
#    "org/virt-manager/virt-manager/connections" = {
#      autoconnect = ["qemu:///system"];
#      uris = ["qemu:///system"];
#    };
#  };
#wayland.windowManager.hyprland.settings = {
#    decoration = {
#      shadow_offset = "0 5";
#      "col.shadow" = "rgba(00000099)";
#    };

#    "$mod" = "SUPER";

#    bindm = [
#      # mouse movements
#      "$mod, mouse:272, movewindow"
#      "$mod, mouse:273, resizewindow"
#      "$mod ALT, mouse:272, resizewindow"
#    ];
#  };

  wayland.windowManager.hyprland = {
    # Whether to enable Hyprland wayland compositor
    enable = true;
    # The hyprland package to use
    package = pkgs.hyprland;
    # Whether to enable XWayland
    xwayland.enable = false;

    # Optional
    # Whether to enable hyprland-session.target on hyprland startup
    #systemd.enable = true;
    # Whether to enable patching wlroots for better Nvidia support
    enableNvidiaPatches = false;
    settings = {
      decoration = {
        shadow_offset = "0 5";
        "col.shadow" = "rgba(00000099)";
      };

      "$mod" = "SUPER";

      bindm = [
        # mouse movements
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod ALT, mouse:272, resizewindow"
      ];
    };
  };

}
