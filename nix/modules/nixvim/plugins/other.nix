{
  programs.nixvim = {
    plugins = {
      # UI
      lualine.enable = true;
      #barbar.enable = true; #bufferline is used insead
      barbecue.enable = true;
      bufferline.enable = true;
      nvim-autopairs.enable = true;
      #ccc.enable = true;
      #typst.enable = true;
      endwise.enable = true;
      comment.enable = true;
      fidget.enable = true;
      flash.enable = true;
      illuminate.enable = true;
      todo-comments.enable = true;
      #persistence.enable = true;
      trim.enable = true;
      trouble.enable = true; #todo customize settings
      wtf.enable = true;
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
