#
#  Hyprland Configuration
#  Enable with "hyprland.enable = true;"
#

{ config, lib, system, pkgs, unstable, hyprland, vars, host, ... }:

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
        grim            # Grab Images
        slurp           # Region Selector
        swappy          # Snapshot Editor
        swayidle        # Idle Daemon
        swaylock        # Lock Screen
        wl-clipboard    # Clipboard
        wlr-randr       # Monitor Settings
        swww            # Wallpaper
        networkmanagerapplet
        bash
      ];
    };
    #security.pam.services.swaylock = {
    #  text = ''
    #   auth include login
    #  '';
    #  enableGnomeKeyring = true;
    #};
    security.pam.services.swaylock = {
        text = ''
          auth sufficient pam_unix.so try_first_pass likeauth nullok
          auth sufficient pam_fprintd.so
          auth include login
        '';
      };
    
    programs.regreet = {
      enable = true;
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
#      settings = {
#        default_session = {
#          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --time-format '%I:%M %p | %a • %h | %F' --cmd Hyprland";
#          #command = "${pkgs.hyprland}/bin/Hyprland";
#          user = vars.user;
#          };
#      };
      vt = 7;
    };
    security.pam.services.greetd = {
      enableGnomeKeyring = true;
      fprintAuth = true;
    };
    programs.seahorse.enable = true;
    programs = {
      hyprland = {                            # Window Manager
        enable = true;
        package = hyprland.packages.${pkgs.system}.hyprland;
        #nvidiaPatches = if hostName == "work" then true else false;
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
    };                                        # Cache

    home-manager.users.${vars.user} =
    let
      touchpad =
        if hostName == "framework" then ''
            touchpad {
              natural_scroll=true
              middle_button_emulation=true
              tap-to-click=true
            }
          
          '' else "";
      gestures =
        if hostName == "framework" then ''
          gestures {
            workspace_swipe=true
            workspace_swipe_fingers=3
            workspace_swipe_distance=100
          }
        '' else "";
      workspaces =
        if hostName == "framework" then ''
          monitor=${toString mainMonitor},2256x1504@60,0x0,1
          monitor=${toString secondMonitor},2560x1440@60,1504x0,1
          monitor=${toString thirdMonitor},2560x1440@60,4064x0,1
          #monitor=${toString secondMonitor},2560x1440@60,0x0,1
          #monitor=${toString thirdMonitor},2560x1440@60,2560x0,1
        '' else ''
          monitor=${toString mainMonitor},1920x1200@60,0x0,1
        '';
      monitors =
        if hostName == "framework" then ''
          workspace=${toString mainMonitor},1
          workspace=${toString secondMonitor},2
          workspace=${toString secondMonitor},3
          workspace=${toString secondMonitor},4
          workspace=${toString secondMonitor},5
          workspace=${toString thirdMonitor},6
          workspace=${toString thirdMonitor},7
          workspace=${toString thirdMonitor},8
          workspace=${toString thirdMonitor},9

          bindl=,switch:Lid Switch,exec,$HOME/.config/hypr/script/clamshell.sh
        '' else "";
      execute =
        if hostName == "framework" then ''
          exec-once=${pkgs.swayidle}/bin/swayidle -w timeout 300 '${pkgs.swaylock}/bin/swaylock -f' timeout 600 '${pkgs.systemd}/bin/systemctl suspend' after-resume '${config.programs.hyprland.package}/bin/hyprctl dispatch dpms on' before-sleep '${pkgs.swaylock}/bin/swaylock -f && ${config.programs.hyprland.package}/bin/hyprctl dispatch dpms off'
        '' else "";

      hyprlandConf = ''
        ${workspaces} 
        ${monitors}
        monitor=,highres,auto,auto

        general {
          #main_mod=SUPER
          border_size=3
          gaps_in=2
          gaps_out=2
          col.active_border=0xff7287fd
          col.inactive_border=0xff585b70
          layout=dwindle
        }

        decoration {
          rounding=8
          active_opacity=0.93
          inactive_opacity=0.93
          fullscreen_opacity=1
          blur {
            enabled=true
          }
          drop_shadow=false
        }

        animations {
          enabled = true
          bezier = overshot, 0.05, 0.9, 0.1, 1.05
          bezier = smoothOut, 0.5, 0, 0.99, 0.99
          bezier = smoothIn, 0.5, -0.5, 0.68, 1.5
          bezier = rotate,0,0,1,1
          animation = windows, 1, 4, overshot, slide
          animation = windowsIn, 1, 2, smoothOut
          animation = windowsOut, 1, 0.5, smoothOut
          animation = windowsMove, 1, 3, smoothIn, slide
          animation = border, 1, 5, default
          animation = fade, 1, 4, smoothIn
          animation = fadeDim, 1, 4, smoothIn
          animation = workspaces, 1, 4, default
          animation = borderangle, 1, 20, rotate, loop
        }

        input {
          kb_layout=de
          #kb_options=caps:ctrl_modifier
          follow_mouse=2
          repeat_delay=250
          numlock_by_default=1
          accel_profile=flat
          sensitivity=0.8
          ${touchpad}
        }

        ${gestures}

        dwindle {
          pseudotile=false
          force_split=2
        }

        misc {
          disable_hyprland_logo=true
          disable_splash_rendering=true
          mouse_move_enables_dpms=true
          key_press_enables_dpms=true
        }

        debug {
          damage_tracking=2
        }

        bindm=SUPER,mouse:272,movewindow
        bindm=SUPER,mouse:273,resizewindow

        bind=SUPER,Return,exec,${pkgs.${vars.terminal}}/bin/${vars.terminal}
        bind=SUPER,Q,killactive,
        bind=SUPER,Escape,exit,
        bind=SUPER,S,exec,${pkgs.systemd}/bin/systemctl suspend
        bind=SUPER,L,exec,${pkgs.swaylock}/bin/swaylock
        bind=SUPER,E,exec,${pkgs.pcmanfm}/bin/pcmanfm
        bind=SUPER,H,togglefloating,
        #bind=SUPER,Space,exec,${pkgs.rofi}/bin/rofi -show drun
        bind=SUPER,Space,exec, pkill wofi || ${pkgs.wofi}/bin/wofi --show drun
        bind=SUPER,P,pseudo,
        bind=SUPER,F,fullscreen,
        bind=SUPER,R,forcerendererreload
        bind=SUPERSHIFT,R,exec,${pkgs.hyprland}/bin/hyprctl reload
        bind=SUPER,T,exec,${pkgs.${vars.terminal}}/bin/${vars.terminal} -e nvim
        bind=SUPER,B,exec,firefox

        bind=SUPER,left,movefocus,l
        bind=SUPER,right,movefocus,r
        bind=SUPER,up,movefocus,u
        bind=SUPER,down,movefocus,d

        bind=SUPERSHIFT,left,movewindow,l
        bind=SUPERSHIFT,right,movewindow,r
        bind=SUPERSHIFT,up,movewindow,u
        bind=SUPERSHIFT,down,movewindow,d
        
        bind=ALT,1,workspace,1
        bind=ALT,2,workspace,2
        bind=ALT,3,workspace,3
        bind=ALT,4,workspace,4
        bind=ALT,5,workspace,5
        bind=ALT,6,workspace,6
        bind=ALT,7,workspace,7
        bind=ALT,8,workspace,8
        bind=ALT,9,workspace,9
        bind=ALT,0,workspace,10
        bind=ALT,right,workspace,+1
        bind=ALT,left,workspace,-1

        bind=ALTSHIFT,1,movetoworkspace,1
        bind=ALTSHIFT,2,movetoworkspace,2
        bind=ALTSHIFT,3,movetoworkspace,3
        bind=ALTSHIFT,4,movetoworkspace,4
        bind=ALTSHIFT,5,movetoworkspace,5
        bind=ALTSHIFT,6,movetoworkspace,6
        bind=ALTSHIFT,7,movetoworkspace,7
        bind=ALTSHIFT,8,movetoworkspace,8
        bind=ALTSHIFT,9,movetoworkspace,9
        bind=ALTSHIFT,0,movetoworkspace,10
        bind=ALTSHIFT,right,movetoworkspace,+1
        bind=ALTSHIFT,left,movetoworkspace,-1

        bind=CTRL,right,resizeactive,20 0
        bind=CTRL,left,resizeactive,-20 0
        bind=CTRL,up,resizeactive,0 -20
        bind=CTRL,down,resizeactive,0 20

        bind=,print,exec,${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" - | ${pkgs.swappy}/bin/swappy -f - -o ~/Pictures/$(date +%Hh_%Mm_%Ss_%d_%B_%Y).png && notify-send "Saved to ~/Pictures/$(date +%Hh_%Mm_%Ss_%d_%B_%Y).png"

        bind=,XF86AudioLowerVolume,exec,${pkgs.pamixer}/bin/pamixer -d 10
        bind=,XF86AudioRaiseVolume,exec,${pkgs.pamixer}/bin/pamixer -i 10
        bind=,XF86AudioMute,exec,${pkgs.pamixer}/bin/pamixer -t
        bind=SUPER_L,c,exec,${pkgs.pamixer}/bin/pamixer --default-source -t
        bind=,XF86AudioMicMute,exec,${pkgs.pamixer}/bin/pamixer --default-source -t
        bind=,XF86MonBrightnessDown,exec,${pkgs.light}/bin/light -U 10
        bind=,XF86MonBrightnessUP,exec,${pkgs.light}/bin/light -A 10

        #windowrule=float,^(Rofi)$
        windowrule=float,title:^(Volume Control)$
        windowrule=float,title:^(Picture-in-Picture)$
        windowrule=pin,title:^(Picture-in-Picture)$
        windowrule=move 75% 75% ,title:^(Picture-in-Picture)$
        windowrule=size 24% 24% ,title:^(Picture-in-Picture)$

        exec-once=dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
        exec-once=${unstable.waybar}/bin/waybar
        exec-once=${unstable.eww}/bin/eww daemon
        #exec-once=$HOME/.config/eww/scripts/eww        # When running eww as a bar
        exec-once=${pkgs.blueman}/bin/blueman-applet
        exec-once=${pkgs.bash}/bin/bash $HOME/.config/hypr/script/swww.sh
        exec-once=${pkgs.networkmanagerapplet}/bin/nm-applet --indicator
        exec-once=${pkgs.nextcloud-client}/bin/nextcloud
        ${execute}
      '';
    in
    {
      xdg.configFile."hypr/hyprland.conf".text = hyprlandConf;

      programs.swaylock.settings = {
        #image = "$HOME/.config/wall"
        color = "000000";
        font-size = "24";
        indicator-idle-visible = true;
        indicator-radius = 100;
        indicator-thickness = 20;
        ring-color = "ffffff";
        show-failed-attempts = true;
      };

      home.file = {
        ".config/hypr/script/clamshell.sh" = {
          text = ''
            #!/bin/sh

            if grep open /proc/acpi/button/lid/LID/state; then
              ${config.programs.hyprland.package}/bin/hyprctl keyword monitor "eDP-1, 2256x1504, 0x0, 1"
            else
              if [[ `hyprctl monitors | grep "Monitor" | wc -l` != 1 ]]; then
                ${config.programs.hyprland.package}/bin/hyprctl keyword monitor "eDP-1, disable"
              else
                ${pkgs.swaylock}/bin/swaylock -f
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
