local M = {}

function M.setup()
  require("base16-colorscheme").setup({
    -- Background tones
    base00 = "#131316", -- Default Background
    base01 = "#1f1f23", -- Lighter Background (status bars)
    base02 = "#292a2d", -- Selection Background
    base03 = "#8f909a", -- Comments, Invisibles
    -- Foreground tones
    base04 = "#c5c6d0", -- Dark Foreground (status bars)
    base05 = "#e4e2e6", -- Default Foreground
    base06 = "#e4e2e6", -- Light Foreground
    base07 = "#e4e2e6", -- Lightest Foreground
    -- Accent colors
    base08 = "#ffb4ab", -- Variables, XML Tags, Errors
    base09 = "#e2bbdc", -- Integers, Constants
    base0A = "#c1c6dd", -- Classes, Search Background
    base0B = "#b3c5ff", -- Strings, Diff Inserted
    base0C = "#e2bbdc", -- Regex, Escape Chars
    base0D = "#b3c5ff", -- Functions, Methods
    base0E = "#c1c6dd", -- Keywords, Storage
    base0F = "#93000a", -- Deprecated, Embedded Tags
  })

  vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#8f909a", bg = "#131316" })
  vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#8f909a", bg = "#131316" })
  vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = "#8f909a", bg = "#131316" })
  vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg = "#8f909a", bg = "#131316" })
  vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = "#8f909a", bg = "#131316" })

  vim.api.nvim_set_hl(0, "TelescopePromptNormal", { link = "Normal" })
  vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { link = "Normal" })
  vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { link = "Normal" })
  vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { link = "Normal" })
  vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { link = "TelescopePreviewTitle" })
  vim.api.nvim_set_hl(0, "lualine_a_buffers_active", { link = "lualine_a_insert" })
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
