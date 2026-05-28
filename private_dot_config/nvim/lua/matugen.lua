local M = {}

function M.setup()
  require("base16-colorscheme").setup({
    -- Background tones
    base00 = "#141314", -- Default Background
    base01 = "#201f20", -- Lighter Background (status bars)
    base02 = "#2a2a2a", -- Selection Background
    base03 = "#919095", -- Comments, Invisibles
    -- Foreground tones
    base04 = "#c8c5cb", -- Dark Foreground (status bars)
    base05 = "#e5e2e2", -- Default Foreground
    base06 = "#e5e2e2", -- Light Foreground
    base07 = "#e5e2e2", -- Lightest Foreground
    -- Accent colors
    base08 = "#ffb4ab", -- Variables, XML Tags, Errors
    base09 = "#d1c3c9", -- Integers, Constants
    base0A = "#c8c5c9", -- Classes, Search Background
    base0B = "#c7c5ce", -- Strings, Diff Inserted
    base0C = "#d1c3c9", -- Regex, Escape Chars
    base0D = "#c7c5ce", -- Functions, Methods
    base0E = "#c8c5c9", -- Keywords, Storage
    base0F = "#93000a", -- Deprecated, Embedded Tags
  })

  vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#919095", bg = "#141314" })
  vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#919095", bg = "#141314" })
  vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = "#919095", bg = "#141314" })
  vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg = "#919095", bg = "#141314" })
  vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = "#919095", bg = "#141314" })

  vim.api.nvim_set_hl(0, "TelescopePromptNormal", { link = "Normal" })
  vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { link = "Normal" })
  vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { link = "Normal" })
  vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { link = "Normal" })
  vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { link = "TelescopePreviewTitle" })
end

-- Register a signal handler for SIGUSR1 (matugen updates)
local signal = vim.uv.new_signal()
signal:start(
  "sigusr1",
  vim.schedule_wrap(function()
    package.loaded["matugen"] = nil
    require("matugen").setup()
  end)
)

return M
