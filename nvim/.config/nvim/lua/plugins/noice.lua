return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    views = {
      cmdline_popup = {
        border = {
          style = "single",
        },
      },
      cmdline_output = {
        border = {
          style = "single",
        },
      },
      messages = {
        border = {
          style = "single",
        },
      },
      popupmenu = {
        border = {
          style = "single",
        },
      },
      confirm = {
        border = {
          style = "single",
        },
      },
    },
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
}
