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
vim.opt.conceallevel = 2
vim.opt.laststatus = 3
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.inccommand = "split"
vim.opt.foldlevel = 99

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
  -- main
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/stevearc/conform.nvim" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("*") },
  { src = "https://github.com/rafamadriz/friendly-snippets" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-context" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/folke/ts-comments.nvim" },

  -- qol
  { src = "https://github.com/dasupradyumna/midnight.nvim" },
  { src = "https://github.com/Nvchad/nvterm" },
  { src = "https://github.com/obsidian-nvim/obsidian.nvim", version = vim.version.range("*") },
  { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
  { src = "https://github.com/nvim-mini/mini.nvim" },
})

-- Plugin setup
-- == main
require("oil").setup({})
require("gitsigns").setup()
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
    html = { "biome" },
    css = { "biome" },
  },
  formatters = {
    stylua = {
      command = "stylua",
      prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
    },
  },
})

-- treesitter
local treesitter_parsers = {
  "lua",
  "rust",
  "typescript",
  "javascript",
  "tsx",
  "jsx",
  "python",
  "c",
  "cpp",
  "html",
  "css",
  "markdown",
  "markdown_inline",
}
local treesitter_filetypes = {
  "lua",
  "rust",
  "typescript",
  "javascript",
  "typescriptreact",
  "javascriptreact",
  "python",
  "c",
  "cpp",
  "html",
  "css",
  "markdown",
  "markdown_inline",
}
require("nvim-treesitter").install(treesitter_parsers)
vim.api.nvim_create_autocmd("FileType", {
  pattern = treesitter_filetypes,
  callback = function()
    vim.treesitter.start()
    vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.wo[0][0].foldmethod = "expr"
  end,
})
require("treesitter-context").setup({
  separator = "-",
})

require("mason").setup()
require("ts-comments").setup()

-- lsp
local servers = { "org", "lua_ls", "ty", "rust_analyzer", "ts_ls", "tailwindcss", "emmet_language_server", "clangd" }
for _, server in ipairs(servers) do
  vim.lsp.enable(server)
end

-- == qol
vim.cmd.colorscheme("midnight")
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })
-- vim.api.nvim_set_hl(0, "Normal", { bg = "black" })
-- vim.api.nvim_set_hl(0, "NormalNC", { bg = "black" })

require("nvterm").setup()

require("mini.pick").setup()
require("mini.surround").setup()
require("mini.pairs").setup()
require("mini.statusline").setup()
require("mini.indentscope").setup()
require("mini.animate").setup({
  cursor = {
    enable = false,
  },
})
require("mini.icons").setup()
require("mini.tabline").setup()

-- `obsidian.nvim` registers blink providers during setup and is not safe to
-- initialize again when this file is re-sourced.
-- if not rawget(_G, "Obsidian") then
--   require("obsidian").setup({
--     legacy_commands = false,
--     workspaces = { {
--       name = "vault",
--       path = "~/Documents/vault",
--     } },
--     note_id_func = function(title)
--       if title ~= nil then
--         return title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
--       end
--       return tostring(os.time())
--     end,
--
--     notes_subdir = "notes",
--     new_notes_location = "notes_subdir",
--
--     note = {
--       template = "default.md",
--     },
--
--     templates = {
--       folder = "templates",
--       date_format = "YYYY-MM-DD",
--       time_format = "HH:mm",
--       substitutions = {
--         project = function()
--           return "default-project"
--         end,
--       },
--     },
--   })
-- end

require("render-markdown").setup()

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
map({ "n", "x" }, "<leader>Y", '"+Y', { desc = "Yank to end of line to clipboard", remap = true })
map({ "n", "x" }, "<leader>d", '"+d', { desc = "Delete to system clipboard" })
map("n", "<leader>dd", '"+dd', { desc = "Delete line to system clipboard" })
map({ "n", "x" }, "<leader>D", '"+D', { desc = "Delete to end of line to system clipboard", remap = true })

-- nvterm
local terminal = require("nvterm.terminal")

map("t", "<C-x>", "<C-\\><C-n>", { desc = "Terminal: Exit Mode" })
map({ "n", "t" }, "<A-h>", function()
  terminal.toggle("horizontal")
end, { desc = "Terminal: Horizontal" })
map({ "n", "t" }, "<A-v>", function()
  terminal.toggle("vertical")
end, { desc = "Terminal: Vertical" })
map({ "n", "t" }, "<A-i>", function()
  terminal.toggle("float")
end, { desc = "Terminal: Float" })
map({ "n", "t" }, "<A-Up>", "<C-\\><C-n><CMD>resize +2<CR>i", { desc = "Terminal: Taller" })
map({ "n", "t" }, "<A-Down>", "<C-\\><C-n><CMD>resize -2<CR>i", { desc = "Terminal: Shorter" })
map({ "n", "t" }, "<A-Right>", "<C-\\><C-n><CMD>vertical resize -2<CR>i", { desc = "Terminal: Wider" })
map({ "n", "t" }, "<A-Left>", "<C-\\><C-n><CMD>vertical resize +2<CR>i", { desc = "Terminal: Narrower" })

-- oil
map("n", "<C-n>", "<CMD>Oil<CR>", { desc = "Open Oil" })

-- org
map("n", "<leader>oc", "<CMD>OrgCapture<CR>", { desc = "Org: Capture" })
map("n", "<leader>oa", "<CMD>OrgAgenda<CR>", { desc = "Org: Agenda" })

-- lsp
map("n", "<leader>fm", function()
  require("conform").format()
end, { desc = "Format current buffer" })
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

    map(
      { "n", "x" },
      "<leader>ca",
      vim.lsp.buf.code_action,
      vim.tbl_extend("force", opts, {
        desc = "LSP: Code Action",
      })
    )
  end,
})

map("n", "<leader>ff", function()
  pick.builtin.files({ tool = "fd" })
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

map("n", "<leader>ft", function()
  extra.pickers.colorschemes()
end, { desc = "Pick colorscheme (mini.pick)" })

map("n", "<tab>", "<CMD>bnext<CR>", { desc = "Buffer: Next" })
map("n", "<S-tab>", "<CMD>bprevious<CR>", { desc = "Buffer: Previous" })
map("n", "<leader>x", "<CMD>bdelete<CR>", { desc = "Buffer: Close" })
map("n", "<leader>X", "<CMD>bdelete!<CR>", { desc = "Buffer: Close (force)" })
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
