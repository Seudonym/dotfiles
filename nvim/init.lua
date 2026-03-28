-- Sanity
vim.g.mapleader = " "
vim.opt.termguicolors = true
vim.opt.guifont = "VictorMono Nerd Font:h12"
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.winborder = "single"
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.laststatus = 3
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.inccommand = "split"

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

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Plugins
vim.pack.add({
  { src = "https://github.com/dasupradyumna/midnight.nvim" },
  { src = "https://github.com/Nvchad/nvterm" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/nvim-mini/mini.nvim" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/saghen/blink.cmp",           version = vim.version.range('*') },
})

vim.cmd.colorscheme("midnight")

vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })

require("nvterm").setup()
require("gitsigns").setup()

-- mini
require("mini.pick").setup()
require("mini.surround").setup()
require("mini.pairs").setup()
require("mini.statusline").setup()
require("mini.indentscope").setup()
require("mini.animate").setup()
require("mini.icons").setup()
require("mini.tabline").setup()

require("oil").setup({})

-- lsp
local servers = { "lua_ls", "ty", "rust_analyzer" }
for _, server in ipairs(servers) do
  vim.lsp.enable(server)
end

require("blink.cmp").setup({
  fuzzy = { implementation = "prefer_rust" },
  keymap = {
    preset = "default",
    ["<CR>"] = { "accept", "fallback" },
    ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
    ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
  },
  appearance = { nerd_font_variant = "mono" },
  completion = {
    documentation = {
      auto_show = true,
    },
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
})


-- Keymaps
-- ==========================
local map = vim.keymap.set
map("i", "jj", "<Esc>", { desc = "Fast Escape" })
map("n", "<Esc>", "<CMD>noh<CR>", { desc = "Turn off highlights" })

map("n", "<C-h>", "<C-w>h", { desc = "Pane: Left" })
map("n", "<C-j>", "<C-w>j", { desc = "Pane: Down" })
map("n", "<C-k>", "<C-w>k", { desc = "Pane: Up" })
map("n", "<C-l>", "<C-w>l", { desc = "Pane: Right" })

map({ "n", "x" }, "<leader>y", '"+y', { desc = "Yank (motion/selection) to clipboard" })
map("n", "<leader>yy", '"+yy', { desc = "Yank line to clipboard" })
map("n", "<leader>Y", '"+y$', { desc = "Yank to end of line to clipboard" })
map({ "n", "x" }, "<leader>d", '"+d', { desc = "Delete to system clipboard" })
map("n", "<leader>dd", '"+dd', { desc = "Delete line to system clipboard" })
map("n", "<leader>D", '"+d$', { desc = "Delete to end of line to system clipboard" })


-- nvterm
local terminal = require("nvterm.terminal")

map("t", "<C-x>", "<C-\\><C-n>", { desc = "Terminal: Exit Mode" })
map({ "n", "t" }, "<A-h>", function() terminal.toggle("horizontal") end, { desc = "Terminal: Horizontal" })
map({ "n", "t" }, "<A-v>", function() terminal.toggle("vertical") end, { desc = "Terminal: Vertical" })
map({ "n", "t" }, "<A-i>", function() terminal.toggle("float") end, { desc = "Terminal: Float" })
map({ "n", "t" }, "<A-Up>", "<C-\\><C-n><CMD>resize +2<CR>i", { desc = "Terminal: Taller" })
map({ "n", "t" }, "<A-Down>", "<C-\\><C-n><CMD>resize -2<CR>i", { desc = "Terminal: Shorter" })
map({ "n", "t" }, "<A-Right>", "<C-\\><C-n><CMD>vertical resize -2<CR>i", { desc = "Terminal: Wider" })
map({ "n", "t" }, "<A-Left>", "<C-\\><C-n><CMD>vertical resize +2<CR>i", { desc = "Terminal: Narrower" })

-- oil
map("n", "<C-n>", "<CMD>Oil<CR>", { desc = "Open Oil" })

-- lsp
map("n", "<leader>fm", vim.lsp.buf.format, { desc = "Format current buffer" })
map("n", "gl", vim.diagnostic.open_float, { desc = "Open diagnostics window" })


-- mini
local extra = require("mini.extra")
local pick = require("mini.pick")

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
  callback = function(event)
    local opts = { buffer = event.buf }

    map("n", "gr", function()
      extra.pickers.lsp({ scope = "references" })
    end, vim.tbl_extend("force", opts, { desc = "LSP: References (mini.pick)" }))

    map("n", "gd", function()
      extra.pickers.lsp({ scope = "definition" })
    end, vim.tbl_extend("force", opts, { desc = "LSP: Definition (mini.pick)" }))

    map("n", "gi", function()
      extra.pickers.lsp({ scope = "implementation" })
    end, vim.tbl_extend("force", opts, { desc = "LSP: Implementation (mini.pick)" }))

    map("n", "gO", function()
      extra.pickers.lsp({ scope = "document_symbol" })
    end, vim.tbl_extend("force", opts, { desc = "LSP: Document Symbols (mini.pick)" }))

    map("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "LSP: Hover" }))

    map("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "LSP: Rename" }))

    map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, {
      desc = "LSP: Code Action",
    }))
  end,
})

map("n", "<leader>ff", function()
  pick.builtin.files({ tool = "git" })
end, { desc = "Find files (mini.pick)" })

map("n", "<leader>fg", function()
  pick.builtin.grep_live({ tool = "rg" })
end, { desc = "Live grep (mini.pick)" })

map("n", "<leader>fb", function()
  pick.builtin.buffers()
end, { desc = "Buffers (mini.pick)" })

map("n", "<leader>fh", function()
  pick.builtin.help()
end, { desc = "Help tags (mini.pick)" })

map("n", "<leader>/", function()
  pick.builtin.grep_live({ scope = "current" })
end, { desc = "Search current buffer (mini.pick)" })

map("n", "<leader>fk", function()
  extra.pickers.keymaps() -- if you define or use a custom keymaps picker
end, { desc = "Find keymaps (mini.pick)" })

map("n", "<leader>fr", function()
  pick.builtin.resume()
end, { desc = "Resume last picker (mini.pick)" })

map("n", "<leader>fc", function()
  pick.builtin.files({
    cwd = vim.fn.expand("~/.config/nvim"),
    tool = "git",
  })
end, { desc = "Find config files (mini.pick)" })

map("n", "<leader>ft", function()
  extra.pickers.colorschemes()
end, { desc = "Pick colorscheme (mini.pick)" })

map("n", "<tab>", "<CMD>bnext<CR>", { desc = "Buffer: Next" })
map("n", "<S-tab>", "<CMD>bprevious<CR>", { desc = "Buffer: Previous" })
map("n", "<leader>x", "<CMD>bdelete<CR>", { desc = "Buffer: Close" })
-- gitsigns
local function gitsigns(action)
  return function()
    require("gitsigns")[action]()
  end
end

local function gitsigns_range(action)
  return function()
    local start_line = vim.fn.line("v")
    local end_line = vim.fn.line(".")
    require("gitsigns")[action]({ math.min(start_line, end_line), math.max(start_line, end_line) })
  end
end
map("n", "]h", gitsigns("next_hunk"), { desc = "Git: Next hunk" })
map("n", "[h", gitsigns("prev_hunk"), { desc = "Git: Previous hunk" })
map("n", "<leader>hn", gitsigns("next_hunk"), { desc = "Git: Next hunk" })
map("n", "<leader>hp", gitsigns("prev_hunk"), { desc = "Git: Previous hunk" })
map("n", "<leader>hs", gitsigns("stage_hunk"), { desc = "Git: Stage hunk" })
map("n", "<leader>hr", gitsigns("reset_hunk"), { desc = "Git: Reset hunk" })
map("v", "<leader>hs", gitsigns_range("stage_hunk"), { desc = "Git: Stage hunk" })
map("v", "<leader>hr", gitsigns_range("reset_hunk"), { desc = "Git: Reset hunk" })
map("n", "<leader>hS", gitsigns("stage_buffer"), { desc = "Git: Stage buffer" })
map("n", "<leader>hR", gitsigns("reset_buffer"), { desc = "Git: Reset buffer" })
map("n", "<leader>hu", gitsigns("undo_stage_hunk"), { desc = "Git: Undo stage hunk" })
map("n", "<leader>hb", gitsigns("blame_line"), { desc = "Git: Blame line" })
map("n", "<leader>hd", gitsigns("diffthis"), { desc = "Git: Diff this" })
map("n", "<leader>hD", function()
  require("gitsigns").diffthis("~")
end, { desc = "Git: Diff against index" })
map("n", "<leader>hq", gitsigns("setqflist"), { desc = "Git: Hunks to quickfix" })

-- vim.pack
map("n", "<leader>pc", pack_clean, { desc = "Clean up Pack" })
