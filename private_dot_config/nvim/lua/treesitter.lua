local treesitter = require("nvim-treesitter")

local ensure_installed = {
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

treesitter.install(ensure_installed)

vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local buf = args.buf
    local ft = vim.bo[buf].filetype
    local lang = vim.treesitter.language.get_lang(ft)
    if not lang then
      return
    end
    local ok_add = pcall(vim.treesitter.language.add, lang)
    if not ok_add then
      return
    end
    pcall(vim.treesitter.start, buf, lang)
  end,
})
