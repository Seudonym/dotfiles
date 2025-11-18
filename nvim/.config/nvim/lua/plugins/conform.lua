return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      rust = { "rustfmt", lsp_format = "fallback" },
      python = { "black", lsp_format = "fallback" },
      typescript = { "prettier" },
      javascript = { "prettier" },
      typescriptreact = { "prettier" },
      javascriptreact = { "prettier" },
    },

    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
  },
}
