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
      ];
      
      file.".config/nvim/lua" = { 
        source = ../../config/nvim/lua;
        executable = true;
      };
      file.".config/nvim/init.lua" = { 
        source = ../../config/nvim/init.lua;
      }; 
      file.".config/nvim/stylua.toml" = { 
        source = ../../config/nvim/stylua.toml;
      };
    };
  };
  
  programs = {
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
    };
  };
}
