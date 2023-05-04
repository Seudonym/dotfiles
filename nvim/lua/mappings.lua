local map = function(mode, key, result) vim.keymap.set(mode, key, result, { noremap = true, silent = true}) end

-- Essenstials
map("i", "jj", "<Esc>")


-- Nvim-Tree
map("n" , "<C-n>", "<cmd>NvimTreeToggle<CR>")
map("n" , "<leader>e", "<C-W>w")

-- Nvterm
map({"n", "i", "t"}, "<A-h>", function() require("nvterm.terminal").toggle("horizontal") end)
map({"n", "i", "t"}, "<A-v>", function() require("nvterm.terminal").toggle("vertical") end)
map({"n", "i", "t"}, "<A-f>", function() require("nvterm.terminal").toggle("float") end)
