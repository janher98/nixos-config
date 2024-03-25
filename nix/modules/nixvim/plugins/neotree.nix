{
  programs.nixvim = {
    plugins = {
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
    };
  };
}
