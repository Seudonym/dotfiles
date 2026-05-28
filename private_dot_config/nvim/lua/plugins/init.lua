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

  local choice = vim.fn.confirm("Remove unused plugins?", "&Yes\n&No", 2)
  if choice == 1 then
    vim.pack.del(unused_plugins)
  end
end

map = vim.keymap.set
map("i", "jj", "<Esc>", { desc = "Fast Escape" })
map("n", "<Esc>", "<CMD>noh<CR>", { desc = "Turn off highlights" })
map("n", "<C-h>", "<C-w>h", { desc = "Pane: Left" })
map("n", "<C-j>", "<C-w>j", { desc = "Pane: Down" })
map("n", "<C-k>", "<C-w>k", { desc = "Pane: Up" })
map("n", "<C-l>", "<C-w>l", { desc = "Pane: Right" })
map({ "n", "x" }, "<leader>y", '"+y', { desc = "Yank (motion/selection) to clipboard" })
map("n", "<leader>yy", '"+yy', { desc = "Yank line to clipboard" })
map({ "n", "x" }, "<leader>Y", '"+Y', { desc = "Yank to end of line to clipboard", remap = true })
map({ "n", "x" }, "<leader>d", '"+d', { desc = "Delete to system clipboard" })
map("n", "<leader>dd", '"+dd', { desc = "Delete line to system clipboard" })
map({ "n", "x" }, "<leader>D", '"+D', { desc = "Delete to end of line to system clipboard", remap = true })

map("n", "gl", vim.diagnostic.open_float, { desc = "Open diagnostics window" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP: Rename" })
map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: Code Action" })

vim.pack.add({
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/stevearc/conform.nvim" },
  { src = "https://github.com/saghen/blink.cmp", version = "1.*" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-context" },
  { src = "https://github.com/neogitorg/neogit" },
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
  { src = "https://github.com/akinsho/bufferline.nvim" },

  -- { src = "https://github.com/obsidian-nvim/obsidian.nvim", version = vim.version.range("*") },
  -- { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
  -- { src = "https://github.com/vyfor/cord.nvim" },
})

require("plugins.oil")
require("plugins.conform")
require("plugins.blink")
require("plugins.treesitter")
require("plugins.telescope")
require("plugins.snacks")
require("plugins.lines")
