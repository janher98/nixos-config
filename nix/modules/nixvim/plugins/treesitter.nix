{
  programs.nixvim = {
    plugins = {
      treesitter = {
        enable = true;
        nixvimInjections = true;
        folding = false;
        nixGrammars = true;
        settings = {
          highlight.enable = true;
          incrementalSelection.enable = true;
          ensureInstalled = "all";
          indent.enable = true;
        };
      };
      treesitter-refactor = {
        enable = true;
      };
      rainbow-delimiters.enable = true;
      otter.enable = true;
    };
  };
}
