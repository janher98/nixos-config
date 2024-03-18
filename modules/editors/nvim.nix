#
#  Neovim
#

{ pkgs, home-manager, vars, ... }:

{
  home-manager.users.${vars.user} = {
    home = {
      packages = with pkgs; [
        gcc
        ripgrep
        fd
        lazygit
        nodejs_21
        cmake
        gnumake42
        asciidoctor
      ];
    };
  };  
}
