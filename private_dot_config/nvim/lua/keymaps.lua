vim.g.mapleader = " "

local map = vim.keymap.set

map("i", "jj", "<Esc>", { desc = "Editor: Fast Escape" })

-- map("n", "<leader>pc", pack_clean, { desc = "Package: Clean vim pack" })

map("n", "<C-h>", "<C-w>h", { desc = "Window: Move left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window: Move down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window: Move up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window: Move right" })

map("n", "<Esc>", "<CMD>noh<CR>", { desc = "Search: Turn off highlights" })
map("n", "n", "nzzzv", { desc = "Search: Centered next result" })
map("n", "N", "Nzzzv", { desc = "Search: Centered prev result" })
-- map("n", "<C-u>", "<C-u>zz", { desc = "Scroll: Centered scroll up" })
-- map("n", "<C-d>", "<C-d>zz", { desc = "Scroll: Centered scroll down" })

map("n", "<A-j>", ":m .+1<CR>==", { desc = "Edit: Move line down" })
map("n", "<A-k>", ":m .-2<CR>==", { desc = "Edit: Move line up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Edit: Move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Edit: Move selection up" })

map({ "n", "x" }, "<leader>y", '"+y', { desc = "Clipboard: Yank to system clipboard" })
map("n", "<leader>yy", '"+yy', { desc = "Clipboard: Yank line to system clipboard" })
map({ "n", "x" }, "<leader>Y", '"+Y', { desc = "Clipboard: Yank to end of line to system clipboard", remap = true })
map({ "n", "x" }, "<leader>d", '"+d', { desc = "Clipboard: Delete to system clipboard" })
map("n", "<leader>dd", '"+dd', { desc = "Clipboard: Delete line to system clipboard" })
map({ "n", "x" }, "<leader>D", '"+D', { desc = "Clipboard: Delete to end of line to system clipboard", remap = true })

map("n", "<leader>u", function()
  vim.cmd.packadd("nvim.undotree")
  require("undotree").open()
end, { desc = "Editor: Toggle undotree" })

map("n", "<Tab>", "<CMD>bnext<CR>", { desc = "Buffer: Next buffer" })
map("n", "<S-Tab>", "<CMD>bprev<CR>", { desc = "Buffer: Previous buffer" })
map("n", "<leader>x", "<CMD>bdelete<CR>", { desc = "Buffer: Delete current buffer" })

map("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, desc = "Terminal: Exit terminal mode" })
map("n", "<A-v>", "<CMD>vsplit | term<CR>i", { desc = "Terminal: Open vertical split" })
map("n", "<A-h>", "<CMD>split | resize 10 | term<CR>i", { desc = "Terminal: Open horizontal split" })
map("n", "<A-i>", "<CMD>enew term<CR>i", { desc = "Terminal: Open in new tab" })
