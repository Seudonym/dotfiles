vim.keymap.set("i", "jj", "<Esc>", { desc = "Fast Escape" })
vim.keymap.set("n", "<C-n>", "<CMD>NvimTreeToggle<CR>", { desc = "Open file tree" })
vim.keymap.set("n", "<leader>e", "<CMD>NvimTreeFocus<CR>", { desc = "Focus file tree" })
vim.keymap.set("n", "<Esc>", "<CMD>noh<CR>", { desc = "Turn off highlights" })

vim.keymap.set("n", "<leader>th", function()
  require("nvchad.themes").open()
end, { desc = "Theme: Live Preview" })

-- tabs
-- Next/Previous Buffer (Tab switching behavior)
vim.keymap.set("n", "<tab>", function()
  require("nvchad.tabufline").next()
end, { desc = "Buffer: Next" })
vim.keymap.set("n", "<S-tab>", function()
  require("nvchad.tabufline").prev()
end, { desc = "Buffer: Previous" })
-- Close Buffer
vim.keymap.set("n", "<leader>x", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "Buffer: Previous" })

-- move between buffers
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Pane: Left" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Pane: Left" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Pane: Left" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Pane: Left" })

-- LSP and formatting keymaps
vim.keymap.set("n", "gl", function()
  vim.diagnostic.open_float()
end, { desc = "Open diagnostics window" })
vim.keymap.set("n", "<leader>fm", function()
  require("conform").format()
  -- vim.lsp.buf.format()
end, { desc = "Format the current buffer" })

-- Escape terminal mode easily
vim.keymap.set("t", "<C-x>", "<C-\\><C-n>", { desc = "Terminal: Exit Mode" })

vim.keymap.set({ "n", "t" }, "<A-h>", function()
  require("nvchad.term").toggle({ pos = "sp", id = "xz" })
end)

vim.keymap.set({ "n", "t" }, "<A-i>", function()
  require("nvchad.term").toggle({ pos = "float", id = "floatTerm" })
end)
vim.keymap.set({ "n", "t" }, "<A-v>", function()
  require("nvchad.term").toggle({ pos = "vsp", id = "xyz" })
end)

-- telescope
vim.keymap.set("n", "<leader>fc", function()
  require("telescope.builtin").find_files({ cwd = vim.fn.expand("~/.config/nvim") })
end)
