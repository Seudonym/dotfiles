-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
require("telescope").setup({
  defaults = {
    border = true,
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
  },
  extensions = {
    fzy_native = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
  pickers = {
    find_files = {
      theme = "dropdown",
    },
    live_grep = {
      theme = "dropdown",
    },
    buffers = {
      theme = "dropdown",
    },
    help_tags = {
      theme = "dropdown",
    },
  },
})
require("telescope").load_extension("fzy_native")
require("telescope").load_extension("ui-select")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fc", function()
  builtin.find_files({ cwd = "~/.config/nvim/" })
end, { desc = "Telescope neovim config" })
vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Telescope diagnostics" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>f/", builtin.current_buffer_fuzzy_find, { desc = "Telescope current buffer search" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
vim.keymap.set("n", "<leader>fH", builtin.builtin, { desc = "Telescope builtin" })
