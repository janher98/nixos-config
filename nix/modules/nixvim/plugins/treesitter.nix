{
  programs.nixvim = {
    plugins = {
      treesitter = {
        enable = true;
        nixvimInjections = true;
        folding = false;
        nixGrammars = true;
        settings = {
          incrementalSelection.enable = true;
          ensureInstalled = "all";
          indent.enable = true;
        };
      };
      treesitter-refactor = {
        enable = true;
      };
    };
  };
}
