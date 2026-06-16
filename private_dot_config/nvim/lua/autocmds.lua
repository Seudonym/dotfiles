-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- close terminal buffer
vim.api.nvim_create_autocmd("TermClose", {
  callback = function()
    -- Get the exit status of the terminal channel
    local exit_status = vim.v.event.status
    if exit_status == 0 then
      -- Safely delete the terminal buffer if it exited successfully
      vim.cmd("bdelete")
    end
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
