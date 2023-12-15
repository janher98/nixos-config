#
#  System Menu
#

{ config, lib, pkgs, vars, ... }:

let
  colors = import ../theming/colors.nix;
in
{
  config = lib.mkIf (config.wlwm.enable) {
    home-manager.users.${vars.user} = {
      home = {
        packages = with pkgs; [
          wofi
        ];
      };

      home.file = {
        ".config/wofi/config" = {
          text = ''
            width=380
            lines=10
            prompt=Search...
            filter_rate=100
            allow_markup=false
            no_actions=true
            halign=fill
            orientation=vertical
            content_halign=fill
            insensitive=true
            allow_images=true
            image_size=40
            hide_scroll=true
          '';
        };
        ".config/wofi/style.css" = with colors.scheme.catppuccin_latte; {
          text = ''
            window {
              margin: 0px;
              background-color: #${surface0};
              font-size: 18px;
            }

            #input {
              all: unset;
              min-height: 40px;
              padding: 8px 20px;
              margin: 8px;
              border: none;
              color: #${text};
              font-weight: bold;
              background-color: #${surface0};
              outline: #${text};
            }

            #inner-box {
              font-weight: bold;
              border-radius: 0px;
            }

            #outer-box {
              margin: 0px;
              padding: 6px;
              border: none;
              border-radius: 20px;
              border: 3px solid #${text};
            }

            #text:selected {
              color: #${surface0};
              background-color: transparent;
            }

            #entry:selected {
              background-color: #${lavender};
            }
          '';
        };
        ".config/wofi/power.sh" = with colors.scheme.catppuccin_latte; {
          executable = true;
          text = ''
            #!/bin/sh

            entries="⏾ Suspend\n⭮ Reboot\n⏻ Shutdown"

            selected=$(echo -e $entries|wofi --dmenu --cache-file /dev/null | awk '{print tolower($2)}')

            case $selected in
              suspend)
                exec systemctl suspend;;
              reboot)
                exec systemctl reboot;;
              shutdown)
                exec systemctl poweroff -i;;
            esac
          '';
        };
      };
    };
  };
}
