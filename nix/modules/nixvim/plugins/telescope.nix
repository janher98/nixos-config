{
  programs.nixvim = {
    plugins = {
      telescope = {
        enable = true;
        keymaps = {
          "<leader>ff" = {
            options.desc = "file finder";
            action = "find_files";
          };
          "<leader>fg" = {
            options.desc = "live grep";
            action = "live_grep";
          };
        };
        extensions = {
          #file_browser.enable = true;
        };
      };
    };
  };
}
