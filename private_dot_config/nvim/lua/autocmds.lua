-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("TermClose", {
  callback = function()
    vim.cmd("bdelete")
  end,
})

-- Kitty autocmds
local kitty_sync_group = vim.api.nvim_create_augroup("KittySync", { clear = true })

-- Remove padding on enter
vim.api.nvim_create_autocmd("VimEnter", {
  group = kitty_sync_group,
  callback = function()
    vim.cmd("silent !kitty @ set-spacing padding=0")
  end,
})

-- Restore padding on exit
vim.api.nvim_create_autocmd("VimLeavePre", {
  group = kitty_sync_group,
  callback = function()
    vim.cmd("silent !kitty @ set-spacing padding=default")
  end,
})

-- Autocommand to close the tree before persistence saves the session
vim.api.nvim_create_autocmd("User", {
  pattern = "PersistenceSavePre",
  callback = function()
    vim.cmd("NvimTreeClose")
  end,
})
