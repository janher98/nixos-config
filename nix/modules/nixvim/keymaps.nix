{
  programs.nixvim = {
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
        key = "<leader>bb";
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
    # Keymaps
    globals = {
      mapleader = " ";
      #maplocalleader = " ";
    };
  };
}
