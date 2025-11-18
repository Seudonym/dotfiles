require("config.options")
require("config.lazy")
require("config.keymap")

-- Colorscheme
vim.opt.termguicolors = true
vim.opt.background = "dark"
--vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
--vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
--vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })

-- Add glsl filetypes
vim.filetype.add({
  extension = {
    ["vert"] = "glsl",
    ["tesc"] = "glsl",
    ["tese"] = "glsl",
    ["frag"] = "glsl",
    ["geom"] = "glsl",
    ["comp"] = "glsl",
    ["vsh"] = "glsl",
    ["fsh"] = "glsl",
  },
})
