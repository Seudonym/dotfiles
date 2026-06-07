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
  "cuda",
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

_G.get_foldtext = function()
  local node = vim.treesitter.get_node({ ignore_injections = false })
  if not node then
    return vim.fn.foldtext()
  end
  while
    node
    and node:type() ~= "function_declaration"
    and node:type() ~= "method_declaration"
    and node:type() ~= "class_declaration"
  do
    node = node:parent()
  end

  if node then
    local name_node = node:childForFieldName("name")
    if name_node then
      local name = vim.treesitter.get_node_text(name_node, 0)
      local line_count = vim.v.foldend - vim.v.foldstart + 1
      return string.format(" %s: %d lines ⋯", name, line_count)
    end
  end

  return vim.fn.foldtext()
end

vim.opt.foldtext = "v:lua.get_foldtext()"

require("treesitter-context").setup({
  separator = "-",
  max_lines = "50%",
  trim_scope = "outer",
})

vim.keymap.set("n", "<leader>ct", "<CMD>TSContext toggle<CR>", { desc = "Toggles treesitter context" })
