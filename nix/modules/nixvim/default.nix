{ pkgs, nixvim, inputs, ... }:
let
  vim-roam = pkgs.vimUtils.buildVimPlugin {
    name = "vim-roam";
    src = pkgs.fetchFromGitHub {
      owner = "jeffmm";
      repo = "vim-roam";
      rev = "ea2c687a708e06005b477402f28c4a3f86b9417e";
      sha256 = "05sbipvsrv4zbgg6k0glr0syj9q5zipp6wylhffln6awq8r7n3j9";
    };
  };
in {
  imports = [
    ./keymaps.nix
    ./plugins/alpha.nix
    ./plugins/autosession.nix
    ./plugins/lsp.nix
    #./plugins/neorg.nix
    ./plugins/neotree.nix
    ./plugins/noice.nix
    ./plugins/other.nix
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
      flavour = "latte";
      #transparentBackground = true;
    };


    # Settings
    options = {
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

    extraPlugins = [
      #vim-roam
      #pkgs.vimPlugins.vimwiki
      #pkgs.vimPlugins.fzf
      ];

  };
}
