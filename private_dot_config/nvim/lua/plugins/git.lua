local neogit = require("neogit")
vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "Open Neogit UI" })

require("gitsigns").setup({})
local gitsigns = require("gitsigns")
vim.keymap.set("n", "]c", function()
  if vim.wo.diff then
    vim.cmd.normal({ "]c", bang = true })
  else
    gitsigns.nav_hunk("next")
  end
end, { desc = "Next hunk" })

vim.keymap.set("n", "[c", function()
  if vim.wo.diff then
    vim.cmd.normal({ "[c", bang = true })
  else
    gitsigns.nav_hunk("prev")
  end
end, { desc = "Previous hunk" })

-- Actions
vim.keymap.set("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage hunk" })
vim.keymap.set("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset hunk" })
vim.keymap.set("v", "<leader>hs", function()
  gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
end, { desc = "Stage selected hunk" })
vim.keymap.set("v", "<leader>hr", function()
  gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
end, { desc = "Reset selected hunk" })
vim.keymap.set("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage buffer" })
vim.keymap.set("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset buffer" })
vim.keymap.set("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview hunk" })
vim.keymap.set("n", "<leader>hi", gitsigns.preview_hunk_inline, { desc = "Preview hunk inline" })
vim.keymap.set("n", "<leader>hb", function()
  gitsigns.blame_line({ full = true })
end, { desc = "Blame line (full)" })
vim.keymap.set("n", "<leader>hd", gitsigns.diffthis, { desc = "Diff against index" })
vim.keymap.set("n", "<leader>hD", function()
  gitsigns.diffthis("~")
end, { desc = "Diff against last commit" })
vim.keymap.set("n", "<leader>hQ", function()
  gitsigns.setqflist("all")
end, { desc = "Send all hunks to quickfix" })
vim.keymap.set("n", "<leader>hq", gitsigns.setqflist, { desc = "Send buffer hunks to quickfix" })

-- Toggles
vim.keymap.set("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Toggle line blame" })
vim.keymap.set("n", "<leader>tw", gitsigns.toggle_word_diff, { desc = "Toggle word diff" })

-- Text object
vim.keymap.set({ "o", "x" }, "ih", gitsigns.select_hunk, { desc = "Select hunk" })
