require("config.options")
require("config.lazy")
require("config.keymap")

-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = { "<filetype>" },
-- 	callback = function()
-- 		vim.treesitter.start()
-- 	end,
-- })

-- Colorscheme
vim.opt.background = "dark"
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
