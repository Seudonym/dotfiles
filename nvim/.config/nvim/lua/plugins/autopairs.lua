return {
  {
    "windwp/nvim-ts-autotag",
    opts = {},
  },
  { "tpope/vim-surround", config = function() end },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
  },
}
