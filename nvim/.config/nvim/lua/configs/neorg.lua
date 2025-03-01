require("neorg").setup({
  load = {
    ["core.defaults"] = {},
    ["core.concealer"] = {},
    ["core.keybinds"] = {
      config = {
        default_keybinds = true,
      },
    },
    ["core.dirman"] = {
      config = {
        workspaces = {
          notes = "~/notes",
          personal = "~/personal"
        },
      },
    },
  }
})
