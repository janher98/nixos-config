
{
  programs.nixvim = {
    plugins = {
      luasnip.enable = true;

      lspkind = {
        enable = true;

        cmp = {
          enable = true;
          menu = {
            nvim_lsp = "[LSP]";
            nvim_lua = "[api]";
            path = "[path]";
            luasnip = "[snip]";
            buffer = "[buffer]";
          };
        };
      };
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";
          mapping = {
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-e>" = "cmp.mapping.close()";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
          };
          sources = [
#            { name = "calc"; }
#            { name = "dictionary"; }
#            { name = "digraphs"; }
#            { name = "fuzzy-buffer"; }
#            { name = "fuzzy-path"; }
#            { name = "git"; }
#            { name = "greek"; }
#            { name = "latex-symbols"; }
            { name = "nvim-lsp"; }
            { name = "luasnip"; }
            { name = "path"; }
#            { name = "rg"; }
#            { name = "snippy"; }
#            { name = "spell"; }
#            { name = "tabby"; }
#            { name = "treesitter"; }
#            { name = "zsh"; }
#            { name = "yanky"; }
#            { name = "vim-lsp"; }
            {
              name = "buffer";
              # Words from other open buffers can also be suggested.
              option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
            }
        ];
        };
      };
      
#      cmp-pandoc-nvim.enable = true;
#      cmp-dictionary.enable = true;
#      cmp-digraphs.enable = true;
#      cmp-fuzzy-buffer.enable = true;
#      cmp-fuzzy-path.enable = true;
#      cmp-git.enable = true;
#      cmp-greek.enable = true;
#      cmp-latex-symbols.enable = true;
#      cmp-nvim-lsp.enable = true;
#      cmp-path.enable = true;
#      cmp-rg.enable = true;
#      cmp-snippy.enable = true;
#      cmp-spell.enable = true;
#      cmp-tabby.enable = true;
#      cmp-treesitter.enable = true;
#      cmp-zsh.enable = true;
#      cmp_yanky.enable = true;
#      cmp-vim-lsp.enable = true;
    };
  };
}
