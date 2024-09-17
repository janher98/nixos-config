{
  programs.nixvim = {
    plugins = {
      # Dev
      lsp-format.enable = true;
      lsp = {
        enable = true;
        servers = {
          hls.enable = true;
          #nil_ls.enable = true;
          rust-analyzer = {
            enable = false;
            installCargo = false;
            installRustc = false;
          };
          clangd.enable = true;
          cmake.enable = true;
          dockerls.enable = true;
          docker-compose-language-service.enable = true;
          marksman.enable = true;
          nixd.enable = true;
          pylsp.enable = true;
          texlab.enable = true;
        };
      };
    };
  };
}
