vim.pack.add({
  "https://github.com/nvim-mini/mini.nvim",
  "https://github.com/nyoom-engineering/oxocarbon.nvim",
  "https://github.com/rafamadriz/friendly-snippets",
  "https://github.com/neovim/nvim-lspconfig",
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  "https://github.com/nvim-treesitter/nvim-treesitter-context",
  "https://github.com/NeoGitOrg/neogit",
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/rmagatti/auto-session",
  { src = "https://github.com/saghen/blink.cmp", version = "v1.10.2" },
  { src = "https://github.com/stevearc/conform.nvim" },
})

local function pack_clean()
  local active_plugins = {}
  local unused_plugins = {}

  for _, plugin in ipairs(vim.pack.get()) do
    active_plugins[plugin.spec.name] = plugin.active
  end

  for _, plugin in ipairs(vim.pack.get()) do
    if not active_plugins[plugin.spec.name] then
      table.insert(unused_plugins, plugin.spec.name)
    end
  end

  if #unused_plugins == 0 then
    print("No unused plugins.")
    return
  end

  vim.pack.del(unused_plugins)
end

local map = vim.keymap.set
map("n", "<leader>pc", pack_clean, { desc = "Package: Clean vim pack" })

require("blink.cmp").setup({
  keymap = {
    preset = "default",
    ["<CR>"] = { "accept", "fallback" },
    ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
    ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
  },
  cmdline = {
    completion = {
      list = {
        selection = {
          preselect = false,
        },
      },
    },
  },
  completion = {
    list = { selection = { preselect = false } },
    documentation = {
      auto_show = true,
    },
    menu = {
      auto_show = true,
    },
  },
})
require("conform").setup({
  format_on_save = {
    timeout_ms = 500,
  },
  formatters_by_ft = {
    lua = { "stylua" },
    rust = { "rustfmt" },
    typescript = { "biome" },
    javascript = { "biome" },
    typescriptreact = { "biome" },
    javascriptreact = { "biome" },
    python = { "black" },
    html = { "biome" },
    css = { "biome" },
    nix = { "nixfmt" },
    c = { "clang-format" },
    cpp = { "clang-format" },
    cuda = { "clang-format" },
  },
  formatters = {
    stylua = {
      command = "stylua",
      prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
    },
  },
  default_format_opts = {
    lsp_format = "fallback",
  },
})

vim.keymap.set("n", "<leader>fm", function()
  require("conform").format()
end, { desc = "Format current buffer" })

require("mini.files").setup()
vim.keymap.set("n", "-", function()
  require("mini.files").open()
end, { desc = "Mini: Toggle file explorer" })

require("mini.notify").setup({
  content = {
    format = function(notif)
      return notif.msg
    end,
  },
})
require("mini.animate").setup({
  cursor = { enable = false },
})
require("mini.surround").setup()
require("mini.pairs").setup()
require("mini.jump2d").setup()
require("mini.indentscope").setup()
require("mini.tabline").setup()
require("mini.statusline").setup()
require("mini.starter").setup({
  header = [[
                                             
      ████ ██████           █████      ██
     ███████████             █████ 
     █████████ ███████████████████ ███   ███████████
    █████████  ███    █████████████ █████ ██████████████
   █████████ ██████████ █████████ █████ █████ ████ █████
 ███████████ ███    ███ █████████ █████ █████ ████ █████
██████  █████████████████████ ████ █████ █████ ████ ██████
]],

  footer = "",
  query_updaters = "abcdefghijklmnopqrstuvwxyz0123456789_.",
})

local MiniPick = require("mini.pick")
local MiniExtra = require("mini.extra")
MiniPick.setup()
MiniExtra.setup()
map("n", "<leader>ff", MiniPick.builtin.files, { desc = "Mini: find files" })
map("n", "<leader>fw", function()
  MiniPick.builtin.grep({ pattern = vim.fn.expand("<cword>") })
end, { desc = "Mini: grep" })
map("n", "<leader>fg", MiniPick.builtin.grep_live, { desc = "Mini: live grep" })
map("n", "<leader>fb", MiniPick.builtin.buffers, { desc = "Mini: buffers" })
map("n", "<leader>fh", MiniPick.builtin.help, { desc = "Mini: help tags" })
map("n", "<leader>fd", MiniExtra.pickers.diagnostic, { desc = "Mini: diagnostics" })
map("n", "<leader>f/", MiniExtra.pickers.buf_lines, { desc = "Mini: current buffer search" })
-- map("n", "<leader>fc", function() MiniPick.builtin.files({ cwd = "~/.config/nvim/" }) end, { desc = "FzfLua neovim config" })

local MiniIcons = require("mini.icons")
MiniIcons.setup()
map("n", "<leader>gg", "<CMD>Neogit<CR>", { desc = "Git: Open Neogit UI" })

require("auto-session").setup({
  auto_restore = false,
})
vim.keymap.set(
  "n",
  "<leader>qs",
  "<CMD>AutoSession restore<CR>",
  { desc = "Session: Load session for current directory" }
)
vim.keymap.set("n", "<leader>qS", "<CMD>AutoSession search<CR>", { desc = "Session: List sessions" })

local gitsigns = require("gitsigns")

gitsigns.setup()
map("n", "]c", function()
  if vim.wo.diff then
    vim.cmd.normal({ "]c", bang = true })
  else
    gitsigns.nav_hunk("next")
  end
end)

map("n", "[c", function()
  if vim.wo.diff then
    vim.cmd.normal({ "[c", bang = true })
  else
    gitsigns.nav_hunk("prev")
  end
end)
map("n", "<leader>hd", gitsigns.diffthis, { desc = "Git: Diff against index" })
map("n", "<leader>hD", function()
  gitsigns.diffthis("~")
end, { desc = "Git: Diff against last commit" })
map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Git: Toggle line blame" })
map("n", "<leader>tw", gitsigns.toggle_word_diff, { desc = "Git: Toggle word diff" })

require("treesitter")
require("lsp")
require("plugins.direnv")
-- require("matugen").setup()
