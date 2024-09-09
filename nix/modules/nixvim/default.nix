{ pkgs, nixvim, inputs, ... }:
{
  imports = [
    ./keymaps.nix
    ./plugins/alpha.nix
    ./plugins/autosession.nix
    ./plugins/image.nix
    ./plugins/lsp.nix
    ./plugins/markdownprev.nix
    #./plugins/neorg.nix
    ./plugins/neotree.nix
    ./plugins/noice.nix
    ./plugins/other.nix
    ./plugins/roam.nix
    ./plugins/telescope.nix
    ./plugins/treesitter.nix
  ];
#  imports = [
#    inputs.nixvim.homeManagerModules.nixvim
#  ];
  programs.nixvim = {
    enable = true;

    # Theme
    colorschemes.catppuccin = {
      enable = true;
      settings.flavour = "latte";
      #transparentBackground = true;
    };


    # Settings
    opts = {
      expandtab = true;
      shiftwidth = 2;
      smartindent = true;
      tabstop = 2;
      number = true;
    };

    extraConfigLua = ''
      local Terminal = require('toggleterm.terminal').Terminal
      local lazygit = Terminal:new({
		    cmd = "lazygit",
		    hidden = true,
		    direction = "float",
		  })
		  function _lazygit_toggle()
		    lazygit:toggle()
		  end
      require('auto-session').setup {
        pre_save_cmds = {"tabdo Neotree close"}
      }
      '';


  };
}
