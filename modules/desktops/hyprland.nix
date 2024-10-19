#
#  Hyprland Configuration
#  Enable with "hyprland.enable = true;"
#

{ config, lib, system, pkgs, stable, hyprland, vars, host, ... }:

let
  colors = import ../theming/colors.nix;
in
with lib;
with host;
{
  options = {
    hyprland = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };

  config = mkIf (config.hyprland.enable) {
    wlwm.enable = true;                       # Wayland Window Manager

    environment =
    let
      exec = "exec dbus-launch Hyprland";
    in
    {
      loginShellInit = ''
        if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
          ${exec}
        fi
      '';                                     # Start from TTY1

      variables = {
        #WLR_NO_HARDWARE_CURSORS="1";         # Needed for VM
        #WLR_RENDERER_ALLOW_SOFTWARE="1";
        XDG_CURRENT_DESKTOP="Hyprland";
        XDG_SESSION_TYPE="wayland";
        XDG_SESSION_DESKTOP="Hyprland";
        XCURSOR = "Catppuccin-Latte-Light-Cursors";
        XCURSOR_SIZE = 24;
      };
      sessionVariables = if hostName == "framework" then {
        #GBM_BACKEND = "nvidia-drm";
        #__GL_GSYNC_ALLOWED = "0";
        #__GL_VRR_ALLOWED = "0";
        #WLR_DRM_NO_ATOMIC = "1";
        #__GLX_VENDOR_LIBRARY_NAME = "nvidia";
        #_JAVA_AWT_WM_NONREPARENTING = "1";

        QT_QPA_PLATFORM = "wayland";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

        GDK_BACKEND = "wayland";
        WLR_NO_HARDWARE_CURSORS = "1";
        MOZ_ENABLE_WAYLAND = "1";
      } else {
        QT_QPA_PLATFORM = "wayland";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

        GDK_BACKEND = "wayland";
        WLR_NO_HARDWARE_CURSORS = "1";
        MOZ_ENABLE_WAYLAND = "1";
      };
      systemPackages = with pkgs; [
        grimblast            # Grab Images
        #swayidle        # Idle Daemon
        #swaylock        # Lock Screen
        hyprcursor
        wl-clipboard    # Clipboard
        wlr-randr       # Monitor Settings
        xwayland # X session
        nwg-look
        swww            # Wallpaper
        networkmanagerapplet
        bash
      ];
    };

    programs.regreet = {
      enable = false;
      settings = {
        background = {
          path = /home/jan/Pictures/wallpapers/shadesofpurple.png;
          fit = "Cover";
        };
        GTK = {
          cursor_theme_name = "Catppuccin-Latte-Light-Cursors";
          font_name = "FiraCode Nerd Font Mono Medium";
          icon_theme_name = "Papirus-Dark";
          theme_name = "Catppuccin-Latte-Compact-Blue-Light";
        };
      };
    };
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
#          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --time-format '%I:%M %p | %a • %h | %F' --cmd Hyprland";
          command = "${pkgs.hyprland}/bin/Hyprland";
          user = vars.user;
          };
      };
      vt = 7;
    };
    #security.pam.services.greetd = {
    #  enableGnomeKeyring = true;
    #  fprintAuth = true;
    #};
    #programs.seahorse.enable = true;
    programs = {
      hyprland = {                            # Window Manager
        enable = true;
        package = hyprland.packages.${pkgs.system}.hyprland;
        #nvidiaPatches = if hostName == "work" then true else false;
      };
    };
    security.pam.services = {
      hyprlock = {
        # text = "auth include system-auth";
        text = "auth include login";
        fprintAuth = if hostName == "framework" then true else false;
        enableGnomeKeyring = true;
      };
      login = {
        enableGnomeKeyring = true;
      };
    };

    systemd.sleep.extraConfig = ''
      AllowSuspend=yes
      AllowHibernation=no
      AllowSuspendThenHibernate=no
      AllowHybridSleep=yes
    '';                                       # Clamshell Mode

    nix.settings = {
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };                                        # Cachei

    home-manager.users.${vars.user} =
      let
        lid = "LID";
        lockScript = pkgs.writeShellScript "lock-script" ''
          action=$1
          ${pkgs.pipewire}/bin/pw-cli i all | ${pkgs.ripgrep}/bin/rg running
          if [ $? == 1 ]; then
            if [ "$action" == "lock" ]; then
              ${pkgs.hyprlock}/bin/hyprlock
            elif [ "$action" == "suspend" ]; then
              ${pkgs.systemd}/bin/systemctl suspend
            fi
          fi
        '';
      in
      {
        imports = [
          hyprland.homeManagerModules.default
        ];
        programs.hyprlock = {
          enable = true;
          settings = {
            general = {
              hide_cursor = true;
              no_fade_in = false;
              disable_loading_bar = true;
              grace = 0;
            };
            background = [{
              monitor = "";
              path = "$HOME/.config/wall.png";
              color = "rgba(25, 20, 20, 1.0)";
              blur_passes = 1;
              blur_size = 0;
              brightness = 0.2;
            }];
            input-field = [
              {
                monitor = "";
                size = "250, 60";
                outline_thickness = 2;
                dots_size = 0.2;
                dots_spacing = 0.2;
                dots_center = true;
                outer_color = "rgba(0, 0, 0, 0)";
                inner_color = "rgba(0, 0, 0, 0.5)";
                font_color = "rgb(200, 200, 200)";
                fade_on_empty = false;
                placeholder_text = ''<i><span foreground="##cdd6f4">Input Password...</span></i>'';
                hide_input = false;
                position = "0, -120";
                halign = "center";
                valign = "center";
              }
            ];
            label = [
              {
                monitor = "";
                text = "$TIME";
                font_size = 120;
                position = "0, 80";
                valign = "center";
                halign = "center";
              }
            ];
          };
        };

        services.hypridle = {
          enable = true;
          settings = {
            general = {
              before_sleep_cmd = "${pkgs.systemd}/bin/loginctl lock-session";
              after_sleep_cmd = "${config.programs.hyprland.package}/bin/hyprctl dispatch dpms on";
              ignore_dbus_inhibit = true;
              lock_cmd = "pidof ${pkgs.hyprlock}/bin/hyprlock || ${pkgs.hyprlock}/bin/hyprlock";
            };
            listener = [
              {
                timeout = 900;
                on-timeout = "${lockScript.outPath} lock";
              }
              {
                timeout = 2700;
                on-timeout = "${lockScript.outPath} suspend";
              }
            ];
          };
        };
        wayland.windowManager.hyprland = with colors.scheme.catppuccin_latte; {
          enable = true;
          package = hyprland.packages.${pkgs.system}.hyprland;
          xwayland.enable = true;
          settings = {
            general = {
              border_size = 3;
              gaps_in = 2;
              gaps_out = 2;
              "col.active_border" = "0xff7287fd";
              "col.inactive_border" = "0xff585b70";
              resize_on_border = true;
              hover_icon_on_border = false;
              layout = "dwindle";
            };
            decoration = {
                rounding = 8;
                active_opacity = 0.95;
                inactive_opacity = 0.90;
                fullscreen_opacity = 1;
                blur = {
                  enabled = true;
                };
                drop_shadow = false;
            };
            monitor = [
                    ",preferred,auto,1,mirror,${toString mainMonitor}"
                  ] ++ (
              if hostName == "framework" then [
                "${toString mainMonitor},2256x1504@60,0x0,1"
                "${toString secondMonitor},2560x1440@60,1504x0,1"
                "${toString thirdMonitor},2560x1440@60,4064x0,1"
                #${toString secondMonitor},2560x1440@60,0x0,1"
                #${toString thirdMonitor},2560x1440@60,2560x0,1"
              ] else [
                "${toString mainMonitor},1920x1200@60,0x0,1"
              ]);
            workspace =
              if hostName == "framework" then [
                "1, monitor:${toString mainMonitor}"
                "2, monitor:${toString secondMonitor}"
                "3, monitor:${toString secondMonitor}"
                "4, monitor:${toString secondMonitor}"
                "5, monitor:${toString secondMonitor}"
                "6, monitor:${toString thirdMonitor}"
                "7, monitor:${toString thirdMonitor}"
                "8, monitor:${toString thirdMonitor}"
                "9, monitor:${toString thirdMonitor}"

              ] else [ ];
              animations = {
                enabled = true;
                bezier = [
                  "overshot, 0.05, 0.9, 0.1, 1.05"
                  "smoothOut, 0.5, 0, 0.99, 0.99"
                  "smoothIn, 0.5, -0.5, 0.68, 1.5"
                  "rotate,0,0,1,1"
                  ];
                animation = [
                  "windows, 1, 4, overshot, slide"
                  "windowsIn, 1, 2, smoothOut"
                  "windowsOut, 1, 0.5, smoothOut"
                  "windowsMove, 1, 3, smoothIn, slide"
                  "border, 1, 5, default"
                  "fade, 1, 4, smoothIn"
                  "fadeDim, 1, 4, smoothIn"
                  "workspaces, 1, 4, default"
                  "borderangle, 1, 20, rotate, loop"
                ];
              };

              input = {
                kb_layout = "de";
                #kb_options=caps:ctrl_modifier
                follow_mouse = 2;
                repeat_delay = 250;
                numlock_by_default = 1;
                accel_profile = "flat";
                sensitivity = 0.8;
                touchpad =
                  if hostName == "framework" then {
                      natural_scroll = true;
                      middle_button_emulation=true;
                      tap-to-click=true;
                  } else { };

              };
            gestures =
              if hostName == "framework" then {
                  workspace_swipe = true;
                  workspace_swipe_fingers = 3;
                  workspace_swipe_distance = 100;
                } else { };
              dwindle = {
                pseudotile = false;
                force_split = 2;
                #preserver_split = true;
              };

              misc = {
                disable_hyprland_logo = true;
                disable_splash_rendering = true;
                mouse_move_enables_dpms = true;
                key_press_enables_dpms = true;
                mouse_move_focuses_monitor = false;
                background_color = "0x111111";
              };

              debug = {
                damage_tracking = 2;
              };

              bindm = [
                "SUPER,mouse:272,movewindow"
                "SUPER,mouse:273,resizewindow"
              ];

              bind= [
              "SUPER,Return,exec,${pkgs.${vars.terminal}}/bin/${vars.terminal}"
              "SUPER,Q,killactive,"
              "SUPER,Escape,exit,"
              "SUPER,S,exec,${pkgs.systemd}/bin/systemctl suspend"
              "SUPER,L,exec,${pkgs.hyprlock}/bin/hyprlock"
              "SUPER,E,exec,${pkgs.pcmanfm}/bin/pcmanfm"
              "SUPER,H,togglefloating,"
              #"SUPER,Space,exec,${pkgs.rofi}/bin/rofi -show drun"
              "SUPER,Space,exec, pkill wofi || ${pkgs.wofi}/bin/wofi --show drun"
              "SUPER,P,pseudo,"
              "SUPER,F,fullscreen,"
              "SUPER,R,forcerendererreload"
              "SUPERSHIFT,R,exec,${pkgs.hyprland}/bin/hyprctl reload"
              "SUPER,T,exec,${pkgs.${vars.terminal}}/bin/${vars.terminal} -e nvim"
              "SUPER,B,exec,firefox"

              "SUPER,left,movefocus,l"
              "SUPER,right,movefocus,r"
              "SUPER,up,movefocus,u"
              "SUPER,down,movefocus,d"

              "SUPERSHIFT,left,movewindow,l"
              "SUPERSHIFT,right,movewindow,r"
              "SUPERSHIFT,up,movewindow,u"
              "SUPERSHIFT,down,movewindow,d"

              "ALT,1,workspace,1"
              "ALT,2,workspace,2"
              "ALT,3,workspace,3"
              "ALT,4,workspace,4"
              "ALT,5,workspace,5"
              "ALT,6,workspace,6"
              "ALT,7,workspace,7"
              "ALT,8,workspace,8"
              "ALT,9,workspace,9"
              "ALT,0,workspace,10"
              "ALT,right,workspace,+1"
              "ALT,left,workspace,-1"

              "ALTSHIFT,1,movetoworkspace,1"
              "ALTSHIFT,2,movetoworkspace,2"
              "ALTSHIFT,3,movetoworkspace,3"
              "ALTSHIFT,4,movetoworkspace,4"
              "ALTSHIFT,5,movetoworkspace,5"
              "ALTSHIFT,6,movetoworkspace,6"
              "ALTSHIFT,7,movetoworkspace,7"
              "ALTSHIFT,8,movetoworkspace,8"
              "ALTSHIFT,9,movetoworkspace,9"
              "ALTSHIFT,0,movetoworkspace,10"
              "ALTSHIFT,right,movetoworkspace,+1"
              "ALTSHIFT,left,movetoworkspace,-1"


              #"print,exec,${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" - | ${pkgs.swappy}/bin/swappy -f - -o ~/Pictures/$(date +%Hh_%Mm_%Ss_%d_%B_%Y).png && notify-send "Saved to ~/Pictures/$(date +%Hh_%Mm_%Ss_%d_%B_%Y).png""

              ",XF86AudioLowerVolume,exec,${pkgs.pamixer}/bin/pamixer -d 10"
              ",XF86AudioRaiseVolume,exec,${pkgs.pamixer}/bin/pamixer -i 10"
              ",XF86AudioMute,exec,${pkgs.pamixer}/bin/pamixer -t"
              "SUPER_L,c,exec,${pkgs.pamixer}/bin/pamixer --default-source -t"
              ",XF86AudioMicMute,exec,${pkgs.pamixer}/bin/pamixer --default-source -t"
              ",XF86MonBrightnessDown,exec,${pkgs.light}/bin/light -U 10"
              ",XF86MonBrightnessUP,exec,${pkgs.light}/bin/light -A 10"
            ];
            binde = [
              "CTRL,right,resizeactive,20 0"
              "CTRL,left,resizeactive,-20 0"
              "CTRL,up,resizeactive,0 -20"
              "CTRL,down,resizeactive,0 20"
            ];
            bindl =
                    if hostName == "framework" then [
                      ",switch:Lid Switch,exec,$HOME/.config/hypr/script/clamshell.sh"
                    ] else [ ];
            #execute =
             # if hostName == "framework" then ''
              #  exec-once=${pkgs.swayidle}/bin/swayidle -w timeout 600 '${pkgs.swaylock}/bin/swaylock -f' timeout 1200 '${pkgs.systemd}/bin/systemctl suspend' after-resume '${config.programs.hyprland.package}/bin/hyprctl dispatch dpms on' before-sleep '${pkgs.swaylock}/bin/swaylock -f && ${config.programs.hyprland.package}/bin/hyprctl dispatch dpms off'
              #'' else "";

            windowrulev2 = [
              #"float,^(Rofi)$"
              "float,title:^(Volume Control)$"
              "float,title:^(Picture-in-Picture)$"
              "pin,title:^(Picture-in-Picture)$"
              "move 75% 75% ,title:^(Picture-in-Picture)$"
              "size 24% 24% ,title:^(Picture-in-Picture)$"
            ];

              exec-once = [
                "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
              #"${pkgs.hyprlock}/bin/hyprlock"
                "${pkgs.waybar}/bin/waybar"
                "${pkgs.eww}/bin/eww daemon"
                #"$HOME/.config/eww/scripts/eww"        # When running eww as a bar
                "${pkgs.swaynotificationcenter}/bin/swaync"
                "${pkgs.blueman}/bin/blueman-applet"
                "${pkgs.bash}/bin/bash $HOME/.config/hypr/script/swww.sh"
                "${pkgs.networkmanagerapplet}/bin/nm-applet --indicator"
                "${pkgs.nextcloud-client}/bin/nextcloud"
              ];
            };
          };
    #      xdg.configFile."hypr/hyprland.conf".text = hyprlandConf;

#      programs.swaylock.settings = {
#        #image = "$HOME/.config/wall"
#        color = "000000";
#        font-size = "24";
#        indicator-idle-visible = true;
#        indicator-radius = 100;
#        indicator-thickness = 20;
#        ring-color = "ffffff";
#        show-failed-attempts = true;
#      };

      home.file = {
        ".config/hypr/script/clamshell.sh" = {
          text = ''
            #!/bin/sh

            if grep open /proc/acpi/button/lid/${lid}/state; then
              ${config.programs.hyprland.package}/bin/hyprctl keyword monitor "eDP-1, 2256x1504, 0x0, 1"
            else
              if [[ `hyprctl monitors | grep "Monitor" | wc -l` != 1 ]]; then
                ${config.programs.hyprland.package}/bin/hyprctl keyword monitor "eDP-1, disable"
              else
                ${pkgs.hyprlock}/bin/hyprlock

                ${pkgs.systemd}/bin/systemctl sleep
              fi
            fi
          '';
          executable = true;
        };
        ".config/hypr/script/swww.sh" = {
          source = ../../config/hypr/scripts/swww.sh;
          executable = true;
        };
      };
    };
  };
}
