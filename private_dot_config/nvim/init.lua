-- sanity
vim.g.mapleader = " "
vim.opt.termguicolors = true
vim.opt.guifont = "VictorMono Nerd Font:h12"
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.winborder = "rounded"
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.conceallevel = 2
vim.opt.concealcursor = "nv"
vim.opt.laststatus = 3
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.inccommand = "split"
vim.opt.foldlevel = 99

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

local servers = {
  "lua_ls",
  "nil_ls",

  "ts_ls",
  "eslint",
  "html",
  "cssls",
  "tailwindcss",
  "emmet_language_server",
  "jsonls",
  "yamlls",

  "bashls",
  "clangd",
  "rust_analyzer",
  "ruff",

  "dockerls",
}
vim.lsp.enable(servers)

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

map("n", "<Tab>", "<CMD>bnext<CR>", { desc = "Next Buffer" })
map("n", "<S-Tab>", "<CMD>bprev<CR>", { desc = "Prev Buffer" })
map("n", "<leader>x", "<CMD>bdelete<CR>", { desc = "Next Buffer" })

map("n", "gK", function()
  local new_config = not vim.diagnostic.config().virtual_lines
  vim.diagnostic.config({ virtual_lines = new_config })
end, { desc = "Toggle diagnostic virtual_lines" })

require("plugins")
require("matugen").setup()
