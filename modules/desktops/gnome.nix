#
#  Gnome Configuration
#  Enable with "gnome.enable = true;"
#

{ config, lib, pkgs, vars, ... }:

with lib;
{
  options = {
    gnome = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };

  config = mkIf (config.gnome.enable) {
    programs = {
#      zsh.enable = true;
      #kdeconnect = {                                    # GSConnect
      #  enable = true;
      #  package = pkgs.gnomeExtensions.gsconnect;
      #};
    };

    services = {
      libinput.enable = true;
      xserver = {
        enable = true;
        xkb = {
          layout = "de";
          options = "eurosign:e";
        };
        modules = [ pkgs.xf86_input_wacom ];
        wacom.enable = true;

        displayManager.gdm = {
          enable = true;                                # Display Manager
          autoSuspend = false;
        };
        desktopManager.gnome.enable = true;             # Desktop Environment
      };
      udev.packages = with pkgs; [
        gnome-settings-daemon
      ];
    };

    environment = {
      systemPackages = with pkgs; [                     # System-Wide Packages
        adwaita-icon-theme
        dconf-editor
        gnome-tweaks
      ];
      gnome.excludePackages = (with pkgs; [             # Ignored Packages
        gnome-tour
        gedit
        atomix
        epiphany
        geary
        gnome-characters
        gnome-contacts
        gnome-initial-setup
        hitori
        iagno
        tali
        yelp
      ]);
    };

    home-manager.users.${vars.user} = {
      dconf.settings = {
        "org/gnome/shell" = {
          favorite-apps = [
            "settings.desktop"
            "kitty.desktop"
            "firefox.desktop"
            "nautilus.desktop"
            # "blueman-manager.desktop"
            # "pavucontrol.desktop"
          ];
          disable-user-extensions = false;
          enabled-extensions = [
            #"trayiconsreloaded@selfmade.pl"
            #"blur-my-shell@aunetx"
            #"drive-menu@gnome-shell-extensions.gcampax.github.com"
            #"dash-to-panel@jderose9.github.com"
            #"just-perfection-desktop@just-perfection"
            #"caffeine@patapon.info"
            #"clipboard-indicator@tudmotu.com"
            #"horizontal-workspace-indicator@tty2.io"
            #"bluetooth-quick-connect@bjarosze.gmail.com"
            #"battery-indicator@jgotti.org"
            #"pip-on-top@rafostar.github.com"
            #"forge@jmmaranan.com"
          ];
        };
#
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-light";
          enable-hot-corners = true;
          clock-show-weekday = true;
          # gtk-theme = "adwaita-dark";
        };
        "org/gnome/desktop/calendar" = {
          show-weekdate = true;
        };
        "org/gnome/desktop/wm/preferences" = {
          action-right-click-titlebar = "toggle-maximize";
          action-middle-click-titlebar = "minimize";
          resize-with-right-button = true;
          mouse-button-modifier = "<super>";
          button-layout = ":minimize,close";
        };
        "org/gnome/desktop/wm/keybindings" = {
           maximize = ["<super>up"];                   # Floating
           unmaximize = ["<super>down"];
        #  maximize = ["@as []"];                        # Tiling
        #  unmaximize = ["@as []"];
          switch-to-workspace-left = ["<alt>left"];
          switch-to-workspace-right = ["<alt>right"];
          switch-to-workspace-1 = ["<alt>1"];
          switch-to-workspace-2 = ["<alt>2"];
          switch-to-workspace-3 = ["<alt>3"];
          switch-to-workspace-4 = ["<alt>4"];
          switch-to-workspace-5 = ["<alt>5"];
          move-to-workspace-left = ["<shift><alt>left"];
          move-to-workspace-right = ["<shift><alt>right"];
          move-to-workspace-1 = ["<shift><alt>1"];
          move-to-workspace-2 = ["<shift><alt>2"];
          move-to-workspace-3 = ["<shift><alt>3"];
          move-to-workspace-4 = ["<shift><alt>4"];
          move-to-workspace-5 = ["<shift><alt>5"];
          move-to-monitor-left = ["<super><alt>left"];
          move-to-monitor-right = ["<super><alt>right"];
          close = ["<super>q" "<alt>f4"];
          toggle-fullscreen = ["<super>f"];
        };
#
        "org/gnome/mutter" = {
          workspaces-only-on-primary = true;
          center-new-windows = true;
          edge-tiling = true;                          # Tiling
        };
        "org/gnome/mutter/keybindings" = {
          toggle-tiled-left = ["<super>left"];         # Floating
          toggle-tiled-right = ["<super>right"];
    #      toggle-tiled-left = ["@as []"];               # Tiling
    #      toggle-tiled-right = ["@as []"];
        };
#
        "org/gnome/settings-daemon/plugins/power" = {
          sleep-inactive-ac-type = "nothing";
          sleep-inactive-ac-timeout = 0;
          power-button-action = "nothing";
        };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
          binding = "<super>return";
          command = "kitty";
          name = "open-terminal";
        };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
          binding = "<super>t";
          command = "nvim";
          name = "open-editor";
        };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
          binding = "<super>e";
          command = "nautilus";
          name = "open-file-browser";
        };

      };
#
      home.packages = with pkgs; [
      #  gnomeextensions.tray-icons-reloaded
      #  gnomeextensions.blur-my-shell
      #  gnomeextensions.removable-drive-menu
      #  gnomeextensions.dash-to-panel
      #  gnomeextensions.battery-indicator-upower
      #  gnomeextensions.just-perfection
      #  gnomeextensions.caffeine
      #  gnomeextensions.clipboard-indicator
      #  gnomeextensions.workspace-indicator-2
      #  gnomeextensions.bluetooth-quick-connect
      #  gnomeextensions.gsconnect
      #  gnomeextensions.pip-on-top
      #  gnomeextensions.pop-shell
      #  gnomeextensions.forge
        # gnomeextensions.fullscreen-avoider
        # gnomeextensions.dash-to-dock
      ];
    };
  };
}
