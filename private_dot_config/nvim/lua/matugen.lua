local M = {}

function M.setup()
  require("base16-colorscheme").setup({
    -- Background tones
    base00 = "#121410", -- Default Background
    base01 = "#1e201c", -- Lighter Background (status bars)
    base02 = "#292b26", -- Selection Background
    base03 = "#8d9386", -- Comments, Invisibles
    -- Foreground tones
    base04 = "#c3c8bb", -- Dark Foreground (status bars)
    base05 = "#e2e3dc", -- Default Foreground
    base06 = "#e2e3dc", -- Light Foreground
    base07 = "#e2e3dc", -- Lightest Foreground
    -- Accent colors
    base08 = "#ffb4ab", -- Variables, XML Tags, Errors
    base09 = "#89d4c9", -- Integers, Constants
    base0A = "#bbccaf", -- Classes, Search Background
    base0B = "#aad297", -- Strings, Diff Inserted
    base0C = "#89d4c9", -- Regex, Escape Chars
    base0D = "#aad297", -- Functions, Methods
    base0E = "#bbccaf", -- Keywords, Storage
    base0F = "#93000a", -- Deprecated, Embedded Tags
  })

  vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#8d9386", bg = "#121410" })
  vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#8d9386", bg = "#121410" })
  vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = "#8d9386", bg = "#121410" })
  vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg = "#8d9386", bg = "#121410" })
  vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = "#8d9386", bg = "#121410" })

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
