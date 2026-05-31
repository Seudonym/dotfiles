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
    list = { selection = { preselect = false } },
    documentation = {
      auto_show = true,
    },
    menu = {
      auto_show = true,
      winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpDocCursorLine,Search:None,BlinkCmpKind:Normal",
    },
    ghost_text = {
      enabled = false,
      show_with_menu = false,
    },
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
})
