require("neorg").setup({
  load = {
    ["core.defaults"] = {},
    ["core.concealer"] = {},
    ["core.summary"] = {},
    ["core.keybinds"] = {
      config = {
        default_keybinds = true,
      },
    },
    ["core.dirman"] = {
      config = {
        workspaces = {
          vault = "~/vault"
        },
      },
    },
    ["core.export"] = {},
  }
})
