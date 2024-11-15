{
  programs.nixvim = {
    plugins = {
      auto-session = {
        enable = true;
        #autoRestore.enabled = false;
        #autoSave.enabled = true;
        settings = {
          enabled = true;
          presets = true;
          auto_restore = true;
          auto_save = true;
        };
      };
    };
  };
}
