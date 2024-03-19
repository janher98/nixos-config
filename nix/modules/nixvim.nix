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
      function get_asciidoc_link()
        -- Finding if there is an url under the cursor
        local line = vim.api.nvim_get_current_line()
        local _, c = unpack(vim.api.nvim_win_get_cursor(0))
        local pattern = "(%a+):(%S*)%[([^%]]+)%]"
        local first, last, kind, uri, args
        repeat
          first, last, kind, uri, args = string.find(line, pattern)
          if first == nil then return nil end
        until(first <= c and c <= last)

        -- TODO consider splitting args on ','

        -- Found match on cursor
        -- TODO actually doing something with it
        print(string.format("Found link of kind %s", kind))
      end
      '';

    # Keymaps
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };
    keymaps = [
      {
        key = "<leader>q";
        action = "<CMD>q<CR>";
        options.desc = "Quit";
      }
      {
        key = "<leader>e";
        action = "<CMD>Neotree toggle<CR>";
        options.desc = "Toggle NeoTree";
      }
      {
        key = "<leader>gg";
        action = ":lua _lazygit_toggle()<CR>";
        options.desc = "Lazygit";
      }
      {
        key = "<leader>tt";
        action = ":ToggleTerm direction=float<CR>";
        options.desc = "Terminal floating";
      }
      {
        key = "<leader>tv";
        action = ":ToggleTerm size=100 direction=vertical<CR>";
        options.desc = "Terminal vertical";
      }
      {
        key = "<leader>th";
        action = ":ToggleTerm direction=horizontal<CR>";
        options.desc = "Terminal horizontal";
      }
    ];
    extraPlugins = [
      vim-roam
      pkgs.vimPlugins.vimwiki
      #pkgs.vimPlugins.fzf
      ];

    plugins = {
      # UI
      lualine.enable = true;
      barbar.enable = true;
      bufferline.enable = true;
      markdown-preview.enable = true;
      #image.enable = true;
      nvim-autopairs.enable = true;
      #typst.enable = true;
      #cmp.enable = true;
      cmp-pandoc-nvim.enable = true;
      fidget.enable = true;
      which-key = {
        enable = true;
      };
      airline = {
        enable = true;
        powerline = true;
      };
      noice = {
        enable = true;
        presets = {
          bottom_search = true;
          command_palette = true;
          long_message_to_split = true;
          #inc_rename = false;
          #lsp_doc_border = false;
        }; 
      };
      toggleterm = {
        enable = true;
      };
      telescope = {
        enable = true;
        keymaps = {
          "<leader>ff" = {
            desc = "file finder";
            action = "find_files";
          };
        };
        extensions = {
          file_browser.enable = true;
        };
      };
      neo-tree = {
        enable = true;
        window.width = 20;
        closeIfLastWindow = true;
        extraOptions = {
          filesystem = {
            filtered_items = {
              visible = true;
            };
          };
        };
      };
      treesitter = {
        enable = true;
        nixvimInjections = true;
        folding = false;
        indent = true;
        nixGrammars = true;
        ensureInstalled = "all";
        incrementalSelection.enable = true;
      };
      treesitter-refactor = {
        enable = true;
      };
      neorg = {
        enable = true;
        lazyLoading = true;
        modules = {
          "core.defaults".__empty = null;
          "core.dirman".config = {
            workspaces = {
              notes = "~/notes";
            };
            default_workspace = "notes";
          };
          "core.concealer".__empty = null;
          "core.completion".config.engine = "nvim-cmp";
        };
      };
      # Dev
      lsp = {
        enable = true;
        servers = {
          hls.enable = true;
          nil_ls.enable = true;
          rust-analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
          };
        };
      };
      alpha = {
        enable = true;
        iconsEnabled = true; # installs nvim-web-devicons.
        layout = [
          {
            type = "padding";
            val = 2;
          }
          {
            type = "text";
            val = [
              "                 ______"
              "                /     /\\"
              "               /     /##\\"
              "              /     /####\\"
              "             /     /######\\"
              "            /     /########\\"
              "           /     /##########\\"
              "          /     /#####/\\#####\\"
              "         /     /#####/++\\#####\\"
              "        /     /#####/++++\\#####\\"
              "       /     /#####/\\+++++\\#####\\"
              "      /     /#####/  \\+++++\\#####\\"
              "     /     /#####/    \\+++++\\#####\\"
              "    /     /#####/      \\+++++\\#####\\"
              "   /     /#####/        \\+++++\\#####\\"
              "  /     /#####/__________\\+++++\\#####\\"
              " /                        \\+++++\\#####\\"
              "/__________________________\\+++++\\####/"
              "\\+++++++++++++++++++++++++++++++++\\##/"
              " \\+++++++++++++++++++++++++++++++++\\/"
              "  ``````````````````````````````````"
              ""
            ];
          }
          {
            type = "padding";
            val = 2;
          }
          {
            type = "group";
            val = [
              {
                command = "<CMD>ene <CR>";
                desc = "  New file";
                shortcut = "<Leader>cn";
              }
              {
                command = ":qa<CR>";
                desc = "  Quit Neovim";
                shortcut = "q";
              }
            ];
          }
          {
            type = "padding";
            val = 2;
          }
          {
            opts = {
              hl = "Keyword";
              position = "center";
            };
            type = "text";
            val = "Question authority. Think for yourself.";
          }
        ];
      };
    };
  };
}
