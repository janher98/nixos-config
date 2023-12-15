#
#  System Notifications
#

{ config, lib, pkgs, vars, ... }:

let
  colors = import ../theming/colors.nix;                  # Import Colors
in
{
  home-manager.users.${vars.user} = {
    home.packages = [ pkgs.libnotify ];                   # Dependency
    services.dunst = {
      enable = true;
      iconTheme = {                                       # Icons
        name = "Papirus Dark";
        package = pkgs.papirus-icon-theme;
        size = "16x16";
      };
      settings = with colors.scheme.catppuccin_latte; {               # Settings
        global = {
          monitor = 0;
          # geometry [{width}x{height}][+/-{x}+/-{y}]
          # geometry = "600x50-50+65";
          width = 300;
          height = 200;
          origin = "top-right";
          offset = "50x50";
          shrink = "yes";
          transparency = 10;
          padding = 16;
          horizontal_padding = 16;
          frame_width = 3;
          frame_color = "#${surface0}";
          separator_color = "frame";
          font = "FiraCode Nerd Font 10";
          line_height = 4;
          idle_threshold = 120;
          markup = "full";
          format = ''<b>%s</b>\n%b'';
          alignment = "left";
          vertical_alignment = "center";
          icon_position = "left";
          word_wrap = "yes";
          ignore_newline = "no";
          show_indicators = "yes";
          sort = true;
          stack_duplicates = true;
          # startup_notification = false;
          hide_duplicate_count = true;
        };
        urgency_low = {                                   # Colors
          background = "#${surface0}";
          foreground = "#${text}";
          timeout = 4;
        };
        urgency_normal = {
          background = "#${surface0}";
          foreground = "#${text}";
          timeout = 4;
        };
        urgency_critical = {
          background = "#${surface0}";
          foreground = "#${text}";
          frame_color = "#${red}";
          timeout = 10;
        };
      };
    };
    xdg.dataFile."dbus-1/services/org.knopwob.dunst.service".source = "${pkgs.dunst}/share/dbus-1/services/org.knopwob.dunst.service";
  };
}
