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
        mode = ["n"];
        key = "<leader>qq";
        action = "<cmd>qa<CR>";
        options.desc = "Quit all";
      }
      {
        mode = ["n"];
        key = "<leader>e";
        action = "<cmd>Neotree toggle<CR>";
        options.desc = "Toggle NeoTree";
      }
      {
        mode = ["n"];
        key = "<leader>gg";
        action = ":lua _lazygit_toggle()<CR>";
        options.desc = "Lazygit";
      }
      # Terminal
      {
        mode = ["n"];
        key = "<leader>tt";
        action = ":ToggleTerm direction=float<CR>";
        options.desc = "Terminal floating";
      }
      {
        mode = ["n"];
        key = "<leader>tv";
        action = ":ToggleTerm size=100 direction=vertical<CR>";
        options.desc = "Terminal vertical";
      }
      {
        mode = ["n"];
        key = "<leader>th";
        action = ":ToggleTerm direction=horizontal<CR>";
        options.desc = "Terminal horizontal";
      }
      # Move to window using the <ctrl> hjkl keys
      {
        key = "<C>h";
        action = "<C-w>h";
        options.desc = "Go to left window";
      }
      {
        mode = ["n"];
        key = "<C>j";
        action = "<C-w>j";
        options.desc = "Go to lower window";
      }
      {
        mode = ["n"];
        key = "<C>k";
        action = "<C-w>k";
        options.desc = "Go to upper window";
      }
      {
        mode = ["n"];
        key = "<C>l";
        action = "<C-w>l";
        options.desc = "Go to right window";
      }
      # Resize window using <ctrl> arrow keys
      {
        mode = ["n"];
        key = "<C-Up>";
        action = "<cmd>resize +2<cr>";
        options.desc = "Increase window heigth";
      }
      {
        mode = ["n"];
        key = "<C-Down>";
        action = "<cmd>resize -2<cr>";
        options.desc = "Decrease window heigth";
      }
      {
        mode = ["n"];
        key = "<C-Left>";
        action = "<cmd>vertical resize +2<cr>";
        options.desc = "Decrease window width";
      }
      {
        mode = ["n"];
        key = "<C-Right>";
        action = "<cmd>vertical resize -2<cr>";
        options.desc = "Increase window width";
      }
      # Move Lines
      {
        mode = ["n"];
        key = "<A-j>";
        action = "<cmd>m .+1<cr>==";
        options.desc = "Move down";
      }
      {
        mode = ["n"];
        key = "<A-k>";
        action = "<cmd>m .-2<cr>==";
        options.desc = "Move up";
      }
      {
        mode = ["i"];
        key = "<A-j>";
        action = "<esc><cmd>m .+1<cr>==gi";
        options.desc = "Move down";
      }
      {
        mode = ["i"];
        key = "<A-k>";
        action = "<esc><cmd>m .-2<cr>==gi";
        options.desc = "Move up";
      }
      {
        mode = ["v"];
        key = "<A-j>";
        action = ":m '>+1<cr>gv=gv";
        options.desc = "Move down";
      }
      {
        mode = ["v"];
        key = "<A-k>";
        action = ":m '<-2<cr>gv=gv";
        options.desc = "Move up";
      }
      # Buffers
      {
        mode = ["n"];
        key = "<S-h>";
        action = "<cmd>bprevious<cr>";
        options.desc = "Prev Buffer";
      }
      {
        mode = ["n"];
        key = "<S-l>";
        action = "<cmd>bnext<cr>";
        options.desc = "Next Buffer";
      }
      {
        mode = ["n"];
        key = "<leader>";
        action = "<cmd>e #<cr>";
        options.desc = "Switch to Other Buffer";
      }
      # Clear search with <esc>
      {
        mode = ["n" "i"];
        key = "<esc>";
        action = "<cmd>noh<cr><esc>";
        options.desc = "Escape and clear search";
      }
      # Add undo breakpoints
      {
        mode = ["i"];
        key = ",";
        action = ",<c-g>u";
      }
      {
        mode = ["i"];
        key = ".";
        action = ".<c-g>u";
      }
      {
        mode = ["i"];
        key = ";";
        action = ";<c-g>u";
      }
      # Better indenting
      {
        mode = ["v"];
        key = "<";
        action = "<gv";
      }
      {
        mode = ["v"];
        key = ">";
        action = ">gv";
      }
      # Save file
      {
        mode = ["n" "i" "x" "s"];
        key = "<C-s>";
        action = "<cmd>w<cr><esc>";
        options.desc = "Save file";
      }
      # New file
      {
        mode = ["n"];
        key = "<leader>fn";
        action = "<cmd>enew<cr>";
        options.desc = "New file";
      }
      # Location and Quickfix list
      {
        mode = ["n"];
        key = "<leader>xl";
        action = "<cmd>lopen<cr>";
        options.desc = "Location List";
      }
      {
        mode = ["n"];
        key = "<leader>xq";
        action = "<cmd>copen<cr>";
        options.desc = "Quickfix List";
      }
      # Terminal mappings 
      {
        mode = ["t"];
        key = "<esc><esc>";
        action = "<c-\\><c-n>";
        options.desc = "Enter Normal Mode";
      }
      {
        mode = ["t"];
        key = "<C-h>";
        action = "<cmd>wincmd h<cr>";
        options.desc = "Go to left window";
      }
      {
        mode = ["t"];
        key = "<C-j>";
        action = "<cmd>wincmd j<cr>";
        options.desc = "Go to lower window";
      }
      {
        mode = ["t"];
        key = "<C-k>";
        action = "<cmd>wincmd k<cr>";
        options.desc = "Go to upper window";
      }
      {
        mode = ["t"];
        key = "<C-l>";
        action = "<cmd>wincmd l<cr>";
        options.desc = "Go to right window";
      }
      # Windows
      {
        mode = ["n"];
        key = "<leader>ww";
        action = "<C-W>p";
        options.desc = "Other window";
      }
      {
        mode = ["n"];
        key = "<leader>wd";
        action = "<C-W>c";
        options.desc = "Delete window";
      }
      {
        mode = ["n"];
        key = "<leader>w-";
        action = "<C-W>s";
        options.desc = "Split window below";
      }
      {
        mode = ["n"];
        key = "<leader>w|";
        action = "<C-W>v";
        options.desc = "Split window right";
      }
      {
        mode = ["n"];
        key = "<leader>-";
        action = "<C-W>s";
        options.desc = "Split window below";
      }
      {
        mode = ["n"];
        key = "<leader>|";
        action = "<C-W>v";
        options.desc = "Split window right";
      }
      # Tabs
      {
        mode = ["n"];
        key = "<leader><tab>l";
        action = "<cmd>tablast<cr>";
        options.desc = "Last Tab";
      }
      {
        mode = ["n"];
        key = "<leader><tab>f";
        action = "<cmd>tabfirst<cr>";
        options.desc = "First Tab";
      }
      {
        mode = ["n"];
        key = "<leader><tab><tab>";
        action = "<cmd>tabnew<cr>";
        options.desc = "New Tab";
      }
      {
        mode = ["n"];
        key = "<leader><tab>]";
        action = "<cmd>tabnext<cr>";
        options.desc = "Next Tab";
      }
      {
        mode = ["n"];
        key = "<leader><tab>d";
        action = "<cmd>tablclose<cr>";
        options.desc = "Close Tab";
      }
      {
        mode = ["n"];
        key = "<leader><tab>[";
        action = "<cmd>tabprevious<cr>";
        options.desc = "Previous Tab";
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
