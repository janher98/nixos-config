{
  programs.nixvim = {
    plugins = {
      # UI
      lualine.enable = true;
      barbar.enable = true;
      bufferline.enable = true;
      #image.enable = true;
      nvim-autopairs.enable = true;
      #typst.enable = true;
      #cmp.enable = true;
      cmp-pandoc-nvim.enable = true;
      fidget.enable = true;
      persistence.enable = true;
      which-key = {
        enable = true;
      };
      airline = {
        enable = true;
        #powerline = true;
      };
      toggleterm = {
        enable = true;
      };
    };
  };
}
