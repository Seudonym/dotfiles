local map = vim.keymap.set
map("n", "gd", vim.lsp.buf.definition, { desc = "LSP: Goto definition" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "LSP: Goto definition" })

map("n", "gl", vim.diagnostic.open_float, { desc = "LSP: Open diagnostic window" })

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("mini.completion").get_lsp_capabilities())

vim.lsp.config("*", { capabilities = capabilities })

vim.lsp.enable({
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
})
