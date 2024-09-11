{
  programs.nixvim = {
    plugins = {
      # UI
      arrow.enable = true;
      lualine.enable = true;
      #barbar.enable = true; #bufferline is used insead
      barbecue.enable = true;
      bufferline.enable = true;
      nvim-autopairs.enable = true;
      ccc.enable = true;
      #typst.enable = true;
      endwise.enable = true;
      comment.enable = true;
      fidget.enable = true;
      flash.enable = true;
      #illuinate = true; # for 24.11
      persistence.enable = true;
      which-key = {
        enable = true;
      };
      #airline = { #lualine used instead

        #enable = true;
        #powerline = true;
      #};
      toggleterm = {
        enable = true;
      };
    };
  };
}
