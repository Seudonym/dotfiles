require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jj", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
map("n", "<leader>ft", "<cmd> Telescope terms <cr>", { desc = "Find Terminals" })

map("n", "<leader>tt", "<cmd> lua require(\"base46\").toggle_transparency() <cr>", { desc = "Toggle transparency" })
