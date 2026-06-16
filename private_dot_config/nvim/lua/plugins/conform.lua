require("conform").setup({
  format_on_save = {
    timeout_ms = 500,
  },
  formatters_by_ft = {
    lua = { "stylua" },
    rust = { "rustfmt" },
    typescript = { "biome" },
    javascript = { "biome" },
    typescriptreact = { "biome" },
    javascriptreact = { "biome" },
    python = { "black" },
    html = { "biome" },
    css = { "biome" },
    nix = { "nixfmt" },
    c = { "clang-format" },
    cpp = { "clang-format" },
    cuda = { "clang-format" },
  },
  formatters = {
    stylua = {
      command = "stylua",
      prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
    },
  },
  default_format_opts = {
    lsp_format = "fallback",
  },
})

vim.keymap.set("n", "<leader>fm", function()
  require("conform").format()
end, { desc = "Format current buffer" })
