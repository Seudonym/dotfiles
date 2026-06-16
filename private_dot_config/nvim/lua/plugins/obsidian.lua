require("obsidian").setup({
  legacy_commands = false, -- this will be removed in 4.0.0
  workspaces = {
    {
      name = "vault",
      path = "~/Documents/vault",
    },
  },
  picker = { name = "fzf-lua" },
  notes_subdir = "notes",
  note_id_func = require("obsidian.builtin").title_id,
  daily_notes = {
    folder = "daily",
  },
  templates = {
    folder = "templates",
    customizations = {
      personal = { notes_subdir = "personal" },
    },
  },
})

-- require("render-markdown").setup({
--   completions = { lsp = { enabled = true } },
--   file_types = { "markdown", "noice" },
-- })
