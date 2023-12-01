return{

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
        "bibtex-tidy",
        "clang-format",
        "clangd",
        "cpplint",
        "cpptools",
        "cmake-language-server",
        "cmakelang",
        "cmakelint",
        "latexindent",
        "textlint",
      },
    },
  },
}
