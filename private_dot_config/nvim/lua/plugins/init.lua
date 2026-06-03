vim.pack.add({
  -- dev
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/stevearc/conform.nvim" },
  { src = "https://github.com/saghen/blink.cmp", version = "1.*" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/mfussenegger/nvim-dap" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-context" },
  { src = "https://github.com/neogitorg/neogit" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/rafamadriz/friendly-snippets" },

  -- telescope
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  { src = "https://github.com/nvim-telescope/telescope-fzy-native.nvim" },
  { src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/folke/snacks.nvim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },

  { src = "https://github.com/RRethy/base16-nvim" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },

  { src = "https://github.com/folke/which-key.nvim" },
  { src = "https://github.com/j-hui/fidget.nvim" },
  { src = "https://github.com/folke/flash.nvim" },
  { src = "https://github.com/folke/ts-comments.nvim" },
  { src = "https://github.com/nvim-mini/mini.pairs" },

  { src = "https://github.com/obsidian-nvim/obsidian.nvim", version = vim.version.range("*") },
  { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
  { src = "https://github.com/nvim-orgmode/orgmode" },
  -- { src = "https://github.com/vyfor/cord.nvim" },
})

require("plugins.oil")
require("plugins.conform")
require("plugins.blink")
require("plugins.treesitter")
require("plugins.telescope")
require("plugins.git")
require("plugins.snacks")
require("plugins.lines")
require("plugins.flash")
require("plugins.dap")
require("plugins.comments")
require("plugins.obsidian")
