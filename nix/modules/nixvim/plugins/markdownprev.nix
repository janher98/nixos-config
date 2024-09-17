{
  programs.nixvim = {
    plugins = {
      markdown-preview = {
        enable = true;
      };
      markview.enable = true;
    };
  };
}
