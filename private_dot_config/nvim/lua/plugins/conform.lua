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
  },
  formatters = {
    stylua = {
      command = "stylua",
      prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
    },
  },
})

map("n", "<leader>fm", function()
  require("conform").format()
end, { desc = "Format current buffer" })
