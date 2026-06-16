require("fzf-lua").setup({
  ui_select = true,
  winopts = {
    border = "single",
    preview = {
      border = "single", -- Neovim preview window border
    },
  },
  keymap = {
    builtin = {
      ["<C-d>"] = "preview-page-down",
      ["<C-u>"] = "preview-page-up",
    },
  },
})

local fzf = require("fzf-lua")
vim.keymap.set("n", "<leader>F", fzf.global, { desc = "FzfLua global" })
vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "FzfLua find files" })
vim.keymap.set("n", "<leader>fc", function()
  fzf.files({ cwd = "~/.config/nvim/" })
end, { desc = "FzfLua neovim config" })
vim.keymap.set("n", "<leader>fd", fzf.diagnostics_workspace, { desc = "FzfLua diagnostics" })
vim.keymap.set("n", "<leader>fg", fzf.live_grep, { desc = "FzfLua live grep" })
vim.keymap.set("n", "<leader>fb", fzf.buffers, { desc = "FzfLua buffers" })
vim.keymap.set("n", "<leader>f/", fzf.lgrep_curbuf, { desc = "FzfLua current buffer search" })
vim.keymap.set("n", "<leader>fh", fzf.help_tags, { desc = "FzfLua help tags" })
vim.keymap.set("n", "<leader>fH", fzf.builtin, { desc = "FzfLua builtin" })
