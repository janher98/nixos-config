#
#  Bar
#

{ config, lib, pkgs, unstable, vars, host, ...}:

with host;
let
  output =
    if hostName == "framework" then [
      mainMonitor
      secondMonitor
      thirdMonitor
    ] else [
      mainMonitor
    ];
  modules-left = with config.programs;
    if hyprland.enable == true then [
      "custom/menu" 
      "cpu" 
      "temperature" 
      "memory" 
      #"disk" 
      "custom/weather"
    ] else if sway.enable == true then [
      "sway/workspaces" "sway/window" "sway/mode"
    ] else [];

  modules-center = [ 
    "hyprland/workspaces" 
    #"clock"
    #"custom/cycle_wall"
    #"custom/lock";
    ];

  modules-right =
    if hostName == "framework" then [
      #"cpu" "memory" "custom/pad" 
      "tray"
      "network"
      "battery" 
      #"custom/pad" 
      "backlight" 
      #"custom/pad" 
      "pulseaudio" 
      #"pulseaudio#microphone"
      #"custom/pad" 
      "clock" 
      #"tray"
      #"custom/power"
    ] else [
      "cpu" "memory" "custom/pad" "battery" "custom/pad" "backlight" "custom/pad" "pulseaudio" "custom/pad" "clock" "tray"
    ];

  sinkBuiltIn="Built-in Audio Analog Stereo";
  sinkVideocard=''Ellesmere HDMI Audio \[Radeon RX 470\/480 \/ 570\/580\/590\] Digital Stereo \(HDMI 3\)'';
  sinkBluetooth="S10 Bluetooth Speaker";
  headset=sinkBuiltIn;
  speaker=sinkBluetooth;
in
{
  config = lib.mkIf (config.wlwm.enable) {
    environment.systemPackages = with unstable; [
      waybar
    ];

    home-manager.users.${vars.user} = {
      programs.waybar = {
        enable = true;
        package = unstable.waybar;
        systemd ={
          enable = true;
          target = "sway-session.target";
        };

        style = ''
          /*Cattppuccin latte theme*/ 

          @define-color base   #eff1f5;
          @define-color mantle #e6e9ef;
          @define-color crust  #dce0e8;

          @define-color text     #4c4f69;
          @define-color subtext0 #6c6f85;
          @define-color subtext1 #5c5f77;

          @define-color surface0 #ccd0da;
          @define-color surface1 #bcc0cc;
          @define-color surface2 #acb0be;

          @define-color overlay0 #9ca0b0;
          @define-color overlay1 #8c8fa1;
          @define-color overlay2 #7c7f93;

          @define-color blue      #1e66f5;
          @define-color lavender  #7287fd;
          @define-color sapphire  #209fb5;
          @define-color sky       #04a5e5;
          @define-color teal      #179299;
          @define-color green     #40a02b;
          @define-color yellow    #df8e1d;
          @define-color peach     #fe640b;
          @define-color maroon    #e64553;
          @define-color red       #d20f39;
          @define-color mauve     #8839ef;
          @define-color pink      #ea76cb;
          @define-color flamingo  #dd7878;
          @define-color rosewater #dc8a78;
          * {
            border: none;
            font-family: FiraCode Nerd Font;
            /*font-weight: bold*/;
            min-height: 0;
            /* set font-size to 100% if font scaling is set to 1.00 using nwg-look */
            /*font-size: 100%;*/
            font-size: 16px;
            text-shadow: none;
            font-feature-settings: '"zero", "ss01", "ss02", "ss03", "ss04", "ss05", "cv31"';
            padding: 0;
            margin: 0;
          }
          window#waybar {
              background: rgba(0, 0, 0, 0);
              /*border-bottom: 1px solid @unfocused_borders;*/
              /*border-radius: 10px;*/
              /*color: #cba6f7;*/
              /*border: 1px solid #cba6f7;*/
          }

          window#waybar.hidden {
              opacity: 0.5;
          }
            
          tooltip {
              background: rgba(0, 0, 0, 0.6);
              border-radius: 10px;
              /*border: 1px solid #cba6f7;*/
          }

          tooltip label {
              /*color: #cba6f7;*/
              margin-right: 2px;
              margin-left: 2px;
          }

          /*-----module groups----*/
          .modules-right {
              background-color: @surface0;
              border: 1px solid @text;
              border-radius: 10px;
          }

          .modules-center {
              background-color: @surface0;
              border: 1px solid @text;
              border-radius: 10px;
          }

          .modules-left {
              background-color: @surface0;
              border: 1px solid @text;
              border-radius: 10px;
            
          }

          #workspaces button {
              padding: 2px;
              color: @lavender;
              margin-right: 5px;
          }
            
          #workspaces button.active {
              color: @teal;
              border-radius: 15px 15px 15px 15px;
          }
            
          #workspaces button.focused {
              color: @lavender;
          }
            
          #workspaces button.urgent {
              color: #11111b;
              border-radius: 10px;
          }
                
          #workspaces button:hover {
              color: @lavender;
              border-radius: 15px;
          }

          #clock,
          #battery,
          #cpu,
          #memory,
          #disk,
          #temperature,
          #network,
          #pulseaudio,
          #wireplumber,
          #mode,
          #tray,
          #cava,
          #backlight,
          #window,
          #idle_inhibitor,
          #mpd,
          #bluetooth,
          #taskbar,
          #taskbar button,
          #workspaces,
          #custom-light_dark,
          #custom-updater,
          #custom-menu,
          #custom-cycle_wall,
          #custom-power,
          #custom-spotify,
          #custom-weather,
          #custom-power,
          #custom-lock,
          #custom-sink
          #custom-weather.severe,
          #custom-weather.sunnyDay,
          #custom-weather.clearNight,
          #custom-weather.cloudyFoggyDay,
          #custom-weather.cloudyFoggyNight,
          #custom-weather.rainyDay,
          #custom-weather.rainyNight,
          #custom-weather.showyIcyDay,
          #custom-weather.snowyIcyNight,
          #custom-weather.default, 
          #idle_inhibitor {
            color:  @text;
            padding: 0px 10px;
            border-radius: 10px;
          }

          #clock {
              color: @blue;
            }
          
          #network {
              color: @red;
          }

          #battery{
              color: @green;
          }

          #battery.warning{
              color: @peach;
          }

          #backlight {
              color: @yellow;
            }

          #pulseaudio {
              color: @mauve;
          } 

          #cpu {
              color: @peach;
            }

          #temperature {
              color: @blue;
          }

          #memory {
              color: @green;
            }

          #disk {
              color: @lavender;
          }

          #custom-menu {
            color: @lavender
          }

          #temperature.critical {
            background-color: @red;
          }

          @keyframes blink {
            to {
              color: #000000;
            }
          }

          #taskbar button.active {
            background-color: @surface2;
          }

          #battery.critical:not(.charging) {
            color: @maroon;
            animation-name: blink;
            animation-duration: 0.5s;
            animation-timing-function: linear;
            animation-iteration-count: infinite;
            animation-direction: alternate;
          }
          #tray {
              background-color: @surface2;
            }
          #workspaces button:nth-child(1) label {
            color: @lavender;
            margin: 0px 8px;
          }

          #workspaces button:nth-child(2) label {
            color: @maroon;
            margin: 0px 8px;
          }

          #workspaces button:nth-child(3) label {
            color: @green;
            margin: 0px 8px;
          }

          #workspaces button:nth-child(4) label {
            color: @mauve;
            margin: 0px 8px;
          }

          #workspaces button:nth-child(5) label {
            color: @yellow;
            margin: 0px 8px;
          }

          #workspaces button:nth-child(6) label {
            color: @flamingo;
            margin: 0px 8px;
          }

          #workspaces button:nth-child(7) label {
            color: @teal;
            margin: 0px 8px;
          }

          #workspaces button:nth-child(8) label {
            color: @yellow;
            margin: 0px 8px;
          }

          #workspaces button:nth-child(9) label {
            color: @sky;
            margin: 0px 8px;
          }

          #workspaces button:nth-child(10) label {
            color: @rosewater;
            margin: 0px 8px;
          }
        '';
        settings = {
          Main = {
            layer = "top";
            position = "top";
            #height = 16;
            output = output;

            modules-left = modules-left;
            modules-center = modules-center;
            modules-right = modules-right;

            "custom/pad" = {
              format = "      ";
              tooltip = false;
            };
            "custom/menu" = {
              format = "";
              #format = "<span font='16'></span>";
              on-click = ''${unstable.eww-wayland}/bin/eww open --toggle menu --screen 0'';
              on-click-right = "${pkgs.wofi}/bin/wofi --show drun";
              tooltip = false;
            };
            "sway/workspaces" = {
              format = "<span font='12'>{icon}</span>";
              format-icons = {
                "1"="";
                "2"="";
                "3"="";
                "4"="";
                "5"="";
              };
              all-outputs = true;
              persistent_workspaces = {
                 "1" = [];
                 "2" = [];
                 "3" = [];
                 "4" = [];
                 "5" = [];
              };
            };
            "wlr/workspaces" = {
              format = "<span font='11'>{name}</span>";
              active-only = false;
              on-click = "activate";
            };
            "hyprland/workspaces" = {
              #format = "<span font='11'>{name}</span>";
              all-outputs = true;
              format = "{icon}";
              format-icons = {
                "1" = "";
                "2" = "";
                "3" = "";
                "4" = "";
                "5" = "";
                "6" = "";
                "7" = "";
                "8" = "";
                "9" = "";
                "10" = "";

                "urgent" = "";
                "active" = "";
                "default" = "";
              };
            };
            backlight = {
              format= "{icon} {percent}%";
              icon-size = "10";
              #format-icons = ["" "" "" "" "" "" "" "" ""];
              format-icons = ["󰃞" "󰃟" "󰃠"];
              tooltip = false;
              on-click = "$HOME/.config/hypr/script/swww.sh";
            };
            battery = {
              interval = 60;
              states = {
                warning = 30;
                critical = 15;
              };
              format = "{icon} {capacity}%";
              format-charging = " {capacity}%";
              format-plugged = " {capacity}%";
              format-full = "{icon} Full";
              #format-alt = "{icon} {time}";
              format-time = "{H}h {M}min";
              tooltip = true;
              tooltip-format = "{timeTo} {power}w";
              format-icons = ["" "" "" "" ""];
              #max-length = 25;
            };
            bluetooth = {
                format = "";
                format-disabled = "";
                format-connected = " {num_connections}";
                tooltip-format = " {device_alias}";
                tooltip-format-connected ="{device_enumerate}";
                tooltip-format-enumerate-connected = " {device_alias}";
              };
            clock = {
              format = "{:%H:%M %p}";
              #format = "{%H:%M}";
              tooltip = false;
              tooltip-format = "<big>{:%B %Y}</big>\n<tt><small>{calendar}</small></tt>";
              on-click = "${unstable.eww-wayland}/bin/eww open --toggle calendar --screen 0";
            };
            cpu = {
              format = " {usage}% 󰍛";
              interval = 1;
            };
            disk = {
              format = "{percentage_used}% ";
              path = "/";
              interval = 30;
            };
            memory = {
              format = "{percentage}% ";
              format-alt = "{used:0.1f}G ";
              #format = "{}% <span font='11'></span>";
              interval = 1;
              tooltip = true;
              tooltip-format = "{used:0.1f}GB/{total:0.1f}G";
              on-click-right = "foot --title btop sh -c 'btop'";
            };
            network = {
              format-wifi = "";
              format-ethernet = "󰈀";
              format-linked = "󱘖 {ifname} (No IP)";
              format-disconnected = "";
              tooltip-format-wifi = "{essid} ({signalStrength}%) {ipaddr}/{cidr}";
              tooltip-format-ethernet = "{ifname} 󰈁";
              tooltip-format-disconnected = "󰈂 Disconnected";
            };
            pulseaudio = {
              format = "{icon} {volume}%";#" {format-source}";
              format-bluetooth = "{icon} {volume}%";#" {format-source}";
              format-bluetooth-muted = "x {volume}%";#" {format-source}";
              format-muted = "x {volume}%";#" {format-source}";
              #format-source = "<span font='10'></span> ";
              #format-source-muted = "<span font='11'> </span> ";
              format-icons = {
                default = [ "" "" "" ];
                headphone = "";
              };
              tooltip-format = "{desc}, {volume}%";
              on-click = "${pkgs.pamixer}/bin/pamixer -t";
              #on-click-right = "${pkgs.pamixer}/bin/pamixer --default-source -t";
              on-click-right = ''${unstable.eww-wayland}/bin/eww open --toggle audio_menu --screen 0'';
              on-click-middle = "${pkgs.pavucontrol}/bin/pavucontrol";
            };
            "pulseaudio#microphone" = {
              format = "{format-source}";
              format-source = " {volume}%";
              format-source-muted = " ";
              on-click = "${pkgs.pamixer}/bin/pamixer --default-source -t";
            };
            temperature = {
              interval = 10;
              tooltip = false;
              critical-threshold = 85;
              format-critical = "{temperatureC}°C {icon}";
              format = "{temperatureC}°C {icon}";
              format-icons = "󰈸";
            };
            "custom/cycle_wall" = {
              format = " ";
              tooltip = true;
              tooltip-format = "Change wallpaper";
              on-click = "$HOME/.config/waybar/scripts/Wallpaper.sh";

            };
            "custom/lock" = {
              format = "";
              on-click = "$HOME//.config/hypr/scripts/LockScreen.sh";
              tooltip = false;
            };
            "custom/power" = {
              format = "  ";
              tooltip = false;
              #on-click = "sh -c '(sleep 0.5s; wlogout --protocol layer-shell)' & disown";
              #on-click = "$HOME/.config/hypr/scripts/WofiPower.sh";
              #on-click-right = "$HOME//.config/hypr/scripts/ChangeBlur.sh";
            };
            "custom/updater" = {
              format = " {}";
              exec = "checkupdates | wc -l";
              exec-if = "[[ $(checkupdates | wc -l) ]]";
              interval = 15;
              on-click = "foot -T update paru -Syu || yay -Syu && notify-send 'The system has been updated'";
              on-click-right = "$HOME//.config/hypr/scripts/WallpaperSwitch.sh";
            };
              
            "custom/weather" = {
              format = "{}";
              format-alt = "{alt}: {}";
              format-alt-click = "click";
              interval = 360;
              return-type = "json";
              exec = "$HOME/.config/waybar/scripts/Weather.sh";
              #"exec = "$HOME//.config/hypr/scripts/Weather.py";
              exec-if = "ping wttr.in -c1";
              tooltip = true;
            };

            "custom/sink" = {
              format = "{}";
              exec = "$HOME/.config/waybar/scripts/sink.sh";
              interval = 2;
              on-click = "$HOME/.config/waybar/scripts/switch.sh";
              tooltip = false;
            };
            tray = {
              icon-size = 17;
              spacing = 8;
            };
          };
        };
      };
      home.file = {
        ".config/waybar/scripts/sink.sh" = {
          text = ''
            #!/bin/sh

            HEAD=$(awk '/ ${headset}/ { print $2 }' <(${pkgs.wireplumber}/bin/wpctl status | grep "*") | head -n 1)
            SPEAK=$(awk '/ ${speaker}/ { print $2 }' <(${pkgs.wireplumber}/bin/wpctl status | grep "*") | head -n 1)

            if [[ $HEAD = "*" ]]; then
              printf "<span font='13'></span>\n"
            elif [[ $SPEAK = "*" ]]; then
              printf "<span font='10'>󰓃</span>\n"
            fi
            exit 0
          '';
          executable = true;
        };
        ".config/waybar/scripts/switch.sh" = {
          text = ''
            #!/bin/sh

            ID1=$(awk '/ ${headset}/ {sub(/.$/,"",$2); print $2 }' <(${pkgs.wireplumber}/bin/wpctl status) | head -n 1)
            ID2=$(awk '/ ${speaker}/ {sub(/.$/,"",$2); print $2 }' <(${pkgs.wireplumber}/bin/wpctl status) | sed -n 2p)

            HEAD=$(awk '/ ${headset}/ { print $2 }' <(${pkgs.wireplumber}/bin/wpctl status | grep "*") | head -n 1)
            SPEAK=$(awk '/ ${speaker}/ { print $2 }' <(${pkgs.wireplumber}/bin/wpctl status | grep "*") | head -n 1)

            if [[ $SPEAK = "*" ]]; then
              ${pkgs.wireplumber}/bin/wpctl set-default $ID1
            elif [[ $HEAD = "*" ]]; then
              ${pkgs.wireplumber}/bin/wpctl set-default $ID2
            fi
            exit 0
          '';
          executable = true;
        };
        ".config/waybar/scripts/Weather.sh" = {
          source = ../../config/hypr/scripts/Weather.sh;
          executable = true;
        };
      };
    };
  };
}
