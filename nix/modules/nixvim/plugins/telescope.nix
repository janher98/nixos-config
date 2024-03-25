{
  programs.nixvim = {
    plugins = {
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
    };
  };
}
