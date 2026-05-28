local treesitter_parsers = {
  "lua",
  "rust",
  "typescript",
  "javascript",
  "tsx",
  "jsx",
  "python",
  "c",
  "cpp",
  "html",
  "css",
  "markdown",
  "markdown_inline",
}

local treesitter_filetypes = {
  "lua",
  "rust",
  "typescript",
  "javascript",
  "typescriptreact",
  "javascriptreact",
  "python",
  "c",
  "cpp",
  "html",
  "css",
  "markdown",
  "markdown_inline",
}

require("nvim-treesitter").install(treesitter_parsers)
vim.api.nvim_create_autocmd("FileType", {
  pattern = treesitter_filetypes,
  callback = function()
    vim.treesitter.start()
    vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.wo[0][0].foldmethod = "expr"
  end,
})

require("treesitter-context").setup({
  separator = "-",
})
