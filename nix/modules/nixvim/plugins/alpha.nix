{
  programs.nixvim = {
    plugins = {
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
                command = "<CMD>Telescope find_files<CR>";
                desc = "  Find file";
                shortcut = "f";
              }
              {
                command = "<CMD>ene <CR>";
                desc = "  New file";
                shortcut = "n";
              }
              {
                command = "<>Telescope oldfiles<CR>";
                desc = "  Recent files";
                shortcut = "r";
              }
              {
                command = "<cmd>Telescope live_grep<CR>";
                desc = "  Find text";
                shortcut = "g";
              }
              {
                command = "<cmd>SessionRestore<cr>";
                desc = "  Restore Session";
                shortcut = "s";
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
