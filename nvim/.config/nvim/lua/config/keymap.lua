vim.keymap.set("i", "jj", "<Esc>", { desc = "Update current file and source config" })
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- FzfLua keymaps
vim.keymap.set("n", "<leader>ff", "<CMD>FzfLua files<CR>", { desc = "Fuzzy find files in current directory" })
vim.keymap.set("n", "<leader>fg", "<CMD>FzfLua live_grep<CR>", { desc = "Fuzzy find files in current directory" })
vim.keymap.set(
  "n",
  "<leader>fc",
  "<CMD>FzfLua files cwd=~/.config/nvim<CR>",
  { desc = "Fuzzy find files in current directory" }
)
vim.keymap.set("n", "<leader>fg", "<CMD>FzfLua live_grep_native<CR>", { desc = "Find current word" })
vim.keymap.set("n", "<leader>fw", "<CMD>FzfLua grep_cword<CR>", { desc = "Find current word" })
vim.keymap.set("n", "<leader>fW", "<CMD>FzfLua grep_cWORD<CR>", { desc = "Find current WORD" })
vim.keymap.set("n", "<leader><leader>", "<CMD>FzfLua buffers<CR>", { desc = "Find current WORD" })
vim.keymap.set("n", "<leader>fb", "<CMD>FzfLua grep_curbuf<CR>", { desc = "Find current WORD" })
vim.keymap.set("n", "<leader>fh", "<CMD>FzfLua helptags<CR>", { desc = "Find help" })

-- LSP and formatting keymaps
vim.keymap.set("n", "gl", function()
  vim.diagnostic.open_float()
end, { desc = "Open diagnostics window" })
vim.keymap.set("n", "<leader>fm", function()
  require("conform").format()
end, { desc = "Format the current buffer" })

-- Copilot remap
vim.keymap.set("i", "<A-l>", 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false,
})
vim.g.copilot_no_tab_map = true

-- Terminal
vim.keymap.set("n", "<C-`>", function()
  require("snacks").terminal.toggle()
end, { desc = "Toggle terminal" })
vim.keymap.set("t", "<C-`>", function()
  require("snacks").terminal.toggle()
end, { desc = "Toggle terminal" })
vim.keymap.set("n", "<C-n>", function()
  require("snacks").terminal.open()
end, { desc = "Open new terminal" })

-- Zen
vim.keymap.set("n", "<leader>z", function()
  require("snacks").zen()
end, { desc = "Toggle zen mode" })

-- Repl
vim.keymap.set("n", "<leader>r", "<Plug>(ReplSendLine)", { desc = "Send line to REPL" })
vim.keymap.set("v", "<leader>r", "<Plug>(ReplSendVisual)", { desc = "Send selection to REPL" })
vim.keymap.set("n", "<leader>c", "<Plug>(ReplSendCell)", { desc = "Send cell to REPL" })
--
-- Molten REPL
-- vim.keymap.set("n", "<leader>mi", ":MoltenInit<CR>", { silent = true, desc = "Initialize the plugin" })
-- vim.keymap.set("n", "<leader>e", ":MoltenEvaluateOperator<CR>", { silent = true, desc = "run operator selection" })
-- vim.keymap.set("n", "<leader>r", ":MoltenEvaluateLine<CR>", { silent = true, desc = "evaluate line" })
-- vim.keymap.set("n", "<leader>rr", ":MoltenReevaluateCell<CR>", { silent = true, desc = "re-evaluate cell" })
-- vim.keymap.set(
--   "v",
--   "<leader>r",
--   ":<C-u>MoltenEvaluateVisual<CR>gv",
--   { silent = true, desc = "evaluate visual selection" }
-- )
