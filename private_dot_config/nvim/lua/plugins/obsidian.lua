require("obsidian").setup({
  legacy_commands = false, -- this will be removed in 4.0.0
  picker = { name = "telescope.nvim" },
  notes_subdir = "notes",
  note_id_func = require("obsidian.builtin").title_id,
  templates = {
    folder = "templates",
  },
  daily_notes = {
    folder = "daily",
  },
  workspaces = {
    {
      name = "vault",
      path = "~/Documents/vault",
    },
  },
})
