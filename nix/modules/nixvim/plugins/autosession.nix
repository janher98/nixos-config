{
  programs.nixvim = {
    plugins = {
      auto-session = {
        enable = true;
        autoRestore.enabled = false;
        autoSave.enabled = true;
        autoSession = {
          enabled = true;
          createEnabled = true;
        };
      };
    };
  };
}
