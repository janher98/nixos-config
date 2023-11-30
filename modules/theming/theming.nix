#
#  GTK
#

{ pkgs, vars, ... }:

{
  home-manager.users.${vars.user} = {
    home = {
      file.".config/wall.png".source = ./wall.png;
#      file.".config/wall.mp4".source = ./wall.mp4;
      pointerCursor = {                     # System-Wide Cursor
        gtk.enable = true;
  #      #name = "Dracula-cursors";
        name = "Catppuccin-Latte-Light-Cursors";
  #      #package = pkgs.dracula-theme;
        package = pkgs.catppuccin-cursors.latteLight;
        size = 16;
      };
    };

    gtk = {                                 # Theming
      enable = true;
      theme = {
        #name = "Dracula";
        name = "Catppuccin-Latte-Compact-Blue-Light";
        #package = pkgs.dracula-theme;
        package = pkgs.catppuccin-gtk.override {
          accents = ["blue"];
          size = "compact";
          variant = "latte";
        };
      };
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };
      font = {
        name = "FiraCode Nerd Font Mono Medium";
      };
    };
  };
}
