{
  programs.nixvim = {
    plugins = {
      markdown-preview = {
        enable = true;
        #extraConfig = {
        #  auto_start = true;
        #};
      };
    };
  };
}
