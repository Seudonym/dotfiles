-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "solarized_osaka",

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
}

-- M.nvdash = { load_on_startup = true }
M.ui = {
  tabufline = {
    lazyload = false
  },
  statusline = {
    theme = "minimal",
  },
  cmp = {
    lspkind_text = true,
    style = "atom",   -- default/flat_light/flat_dark/atom/atom_colored
    format_colors = {
      tailwind = true,
    }
  }
}

return M
