return {

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    -- event={"VeryLazy"},
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = {
          "c",
          "lua",
          "vim",
          "vimdoc",
          "query",
          "elixir",
          "heex",
          "javascript",
          "html",
        },
        sync_install = false,
        highlight = {
          enable = true,
          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn", -- set to `false` to disable one of the mappings
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
        -- indent = {
        --   enable = true,
        -- },
        -- rainbow = {
        --   enable = true,
        --   -- list of languages you want to disable the plugin for
        --   disable = { 'jsx', 'cpp' },
        --   -- Which query to use for finding delimiters
        --   query = 'rainbow-parens',
        --   -- Highlight the entire buffer all at once
        --   strategy = require('ts-rainbow').strategy.global,
        -- },
      })
    end,
  },
}
