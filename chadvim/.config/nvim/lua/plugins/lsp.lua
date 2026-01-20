return {
  "saghen/blink.cmp",
  version = "v0.*",
  dependencies = {
    "rafamadriz/friendly-snippets",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    { "j-hui/fidget.nvim",                        opts = {} },
    -- Telescope
    "nvim-telescope/telescope.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-lua/plenary.nvim", -- Required for telescope
    "stevearc/conform.nvim",
  },

  opts = {
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
  },

  config = function(_, opts)
    -- 1. Setup Plugins
    require("blink.cmp").setup(opts)
    require("telescope").setup({
      extensions = { ["ui-select"] = { require("telescope.themes").get_dropdown() } },
    })
    require("telescope").load_extension("ui-select")

    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
    vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help Tags" })

    require("mason").setup()

    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black", lsp_format = "fallback" },
        typescript = { "prettierd" },
        javascript = { "prettierd" },
        typescriptreact = { "prettierd" },
        javascriptreact = { "prettierd" },
      },

      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    })

    -- 3. LSP Setup
    local lspconfig = require("lspconfig")
    local capabilities = require("blink.cmp").get_lsp_capabilities()

    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls", "pyright", "clangd", "vtsls" },
      handlers = {
        function(server_name)
          lspconfig[server_name].setup({ capabilities = capabilities })
        end,
        ["lua_ls"] = function()
          lspconfig.lua_ls.setup({
            capabilities = capabilities,
            settings = { Lua = { diagnostics = { globals = { "vim" } } } },
          })
        end,
      },
    })

    -- 4. LSP Specific Keymaps
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
      callback = function(event)
        local b_opts = { buffer = event.buf }

        -- Telescope LSP Pickers
        vim.keymap.set(
          "n",
          "gr",
          builtin.lsp_references,
          { buffer = event.buf, desc = "LSP: [G]oto [R]eferences" }
        )
        vim.keymap.set(
          "n",
          "gd",
          builtin.lsp_definitions,
          { buffer = event.buf, desc = "LSP: [G]oto [D]efinition" }
        )
        vim.keymap.set(
          "n",
          "gi",
          builtin.lsp_implementations,
          { buffer = event.buf, desc = "LSP: [G]oto [I]mplementation" }
        )

        -- Native LSP functions (Fixed the code_action nil error)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, b_opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, b_opts)
        vim.keymap.set({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, b_opts)
      end,
    })
  end,
}
