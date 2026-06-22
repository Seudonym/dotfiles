vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  callback = function()
    vim.hl.on_yank()
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
