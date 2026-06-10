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

local map = vim.keymap.set

map("i", "jj", "<Esc>", { desc = "Editor: Fast Escape" })

map("n", "<leader>pc", pack_clean, { desc = "Package: Clean vim pack" })

map("n", "<C-h>", "<C-w>h", { desc = "Window: Move left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window: Move down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window: Move up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window: Move right" })

map("n", "<Esc>", "<CMD>noh<CR>", { desc = "Search: Turn off highlights" })
map("n", "n", "nzzzv", { desc = "Search: Centered forward results and unfold" })
map("n", "N", "Nzzzv", { desc = "Search: Centered backward results and unfold" })

map("n", "<A-j>", ":m .+1<CR>==", { desc = "Edit: Move line down" })
map("n", "<A-k>", ":m .-2<CR>==", { desc = "Edit: Move line up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Edit: Move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Edit: Move selection up" })

map({ "n", "x" }, "<leader>y", '"+y', { desc = "Clipboard: Yank to system clipboard" })
map("n", "<leader>yy", '"+yy', { desc = "Clipboard: Yank line to system clipboard" })
map({ "n", "x" }, "<leader>Y", '"+Y', { desc = "Clipboard: Yank to end of line to system clipboard", remap = true })
map({ "n", "x" }, "<leader>d", '"+d', { desc = "Clipboard: Delete to system clipboard" })
map("n", "<leader>dd", '"+dd', { desc = "Clipboard: Delete line to system clipboard" })
map({ "n", "x" }, "<leader>D", '"+D', { desc = "Clipboard: Delete to end of line to system clipboard", remap = true })

map("n", "gl", vim.diagnostic.open_float, { desc = "LSP: Open diagnostics window" })
map("n", "gd", vim.lsp.buf.definition, { desc = "LSP: Goto definition" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "LSP: Goto declaration" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP: Rename" })
map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: Code Action" })
map("n", "gK", function()
  local new_config = not vim.diagnostic.config().virtual_lines
  vim.diagnostic.config({ virtual_lines = new_config })
end, { desc = "LSP: Toggle diagnostic virtual lines" })

map("n", "<Tab>", "<CMD>bnext<CR>", { desc = "Buffer: Next buffer" })
map("n", "<S-Tab>", "<CMD>bprev<CR>", { desc = "Buffer: Previous buffer" })
map("n", "<leader>x", "<CMD>bdelete<CR>", { desc = "Buffer: Delete current buffer" })

map("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, desc = "Terminal: Exit terminal mode" })
map("n", "<A-v>", "<CMD>vsplit | term<CR>i", { desc = "Terminal: Open vertical split" })
map("n", "<A-h>", "<CMD>split | term<CR>i", { desc = "Terminal: Open horizontal split" })
map("n", "<A-i>", "<CMD>tab term<CR>i", { desc = "Terminal: Open in new tab" })
