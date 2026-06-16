require("oil").setup({
  view_options = {
    show_hidden = true,
  },
  columns = {
    "icon",
    "permissions",
    "size",
    "mtime",
  },
  float = {
    preview_split = "right",
  },
})
vim.keymap.set("n", "<C-n>", function()
  require("oil").open_float()
end, { desc = "Open Oil" })
