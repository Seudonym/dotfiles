local servers = {
  "lua_ls",
  "nixd",
  "neocmake",
  "marksman",

  "ts_ls",
  "eslint",
  "html",
  "cssls",
  "tailwindcss",
  "emmet_language_server",
  "jsonls",
  "yamlls",

  "bashls",
  "clangd",
  "rust_analyzer",
  "basedpyright",

  "dockerls",
}
vim.lsp.enable(servers)
