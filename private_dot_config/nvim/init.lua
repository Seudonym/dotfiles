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
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.fillchars:append({ eob = " " })
vim.opt.scrolloff = 8

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
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- vim.api.nvim_create_autocmd("TermClose", {
--   callback = function()
--     -- Get the exit status of the terminal channel
--     local exit_status = vim.v.event.status
--     if exit_status == 0 then
--       -- Safely delete the terminal buffer if it exited successfully
--       vim.cmd("bdelete")
--     end
--   end,
-- })

-- Kitty autocmds
local kitty_sync_group = vim.api.nvim_create_augroup("KittySync", { clear = true })

-- Remove padding on enter
vim.api.nvim_create_autocmd("VimEnter", {
  group = kitty_sync_group,
  callback = function()
    vim.cmd("silent !kitty @ set-spacing padding=0")
  end,
})

-- Restore padding on exit
vim.api.nvim_create_autocmd("VimLeavePre", {
  group = kitty_sync_group,
  callback = function()
    vim.cmd("silent !kitty @ set-spacing padding=default")
  end,
})

-- restart with session saved

vim.keymap.set("i", "jj", "<Esc>", { desc = "Fast Escape" })
vim.keymap.set("n", "<leader>pc", pack_clean, { desc = "Clean vim pack" })
vim.keymap.set("n", "<Esc>", "<CMD>noh<CR>", { desc = "Turn off highlights" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Pane: Left" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Pane: Down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Pane: Up" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Pane: Right" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Centered forward search results and unfold" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Centered backward search results and unfold" })
-- vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Centered scroll down" })
-- vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Centered scroll down" })

vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

vim.keymap.set({ "n", "x" }, "<leader>y", '"+y', { desc = "Yank (motion/selection) to clipboard" })
vim.keymap.set("n", "<leader>yy", '"+yy', { desc = "Yank line to clipboard" })
vim.keymap.set({ "n", "x" }, "<leader>Y", '"+Y', { desc = "Yank to end of line to clipboard", remap = true })
vim.keymap.set({ "n", "x" }, "<leader>d", '"+d', { desc = "Delete to system clipboard" })
vim.keymap.set("n", "<leader>dd", '"+dd', { desc = "Delete line to system clipboard" })
vim.keymap.set({ "n", "x" }, "<leader>D", '"+D', { desc = "Delete to end of line to system clipboard", remap = true })

vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Open diagnostics window" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Goto definition" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Goto declaration" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP: Rename" })
vim.keymap.set({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: Code Action" })

vim.keymap.set("n", "<Tab>", "<CMD>bnext<CR>", { desc = "Next Buffer" })
vim.keymap.set("n", "<S-Tab>", "<CMD>bprev<CR>", { desc = "Prev Buffer" })
vim.keymap.set("n", "<leader>x", "<CMD>bdelete<CR>", { desc = "Next Buffer" })

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, desc = "Quit terminal mode" })
vim.keymap.set("n", "<A-v>", "<CMD>vsplit | term<CR>i", { desc = "Vertical terminal split" })
vim.keymap.set("n", "<A-h>", "<CMD>split | term<CR>i", { desc = "Horizontal terminal split" })
vim.keymap.set("n", "<A-i>", "<CMD>tab term<CR>i", { desc = "New tab terminal" })

vim.keymap.set("n", "gK", function()
  local new_config = not vim.diagnostic.config().virtual_lines
  vim.diagnostic.config({ virtual_lines = new_config })
end, { desc = "Toggle diagnostic virtual_lines" })

require("lsp")
require("plugins")
require("matugen").setup()
