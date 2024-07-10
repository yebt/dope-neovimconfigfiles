return {
  -- lspconfig
  -- {
  --   'neovim/nvim-lspconfig',
  --   -- event = "VeryLazy",
  --   -- config = require("plugins.configs.lspconfig")
  -- },

  -- Servers
  {
    -- lspconfig
    'neovim/nvim-lspconfig',
    dependencies = {
      --bridge
      'williamboman/mason-lspconfig.nvim',
      -- pavkages
      'williamboman/mason.nvim',

      'nvimdev/epo.nvim',
    },
    event = 'VeryLazy',
    config = require('plugins.configs.lspconfig'),
  },

  -- NONE
  {
    'nvimtools/none-ls.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },

  -- Completions
  {
    'nvimdev/epo.nvim',
    cond = _G.kernel.opts.plugins.completion == 'epo',
    lazy = false,
    priority = 10000,
    -- event = { 'InsertEnter', 'LspAttach' },
    -- event = { 'LspAttach' },
    config = require('plugins.configs.epo'),
  },

  -- Completions
  {
    'hrsh7th/nvim-cmp',
    event = { 'InsertEnter', 'LspAttach' },
    cond = _G.kernel.opts.plugins.completion == 'cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      --
      -- "L3MON4D3/LuaSnip",
      -- "saadparwaiz1/cmp_luasnip",
      'onsails/lspkind.nvim',
    },
    config = require('plugins.configs.cmp'),
  },
  --
  {
    'echasnovski/mini.completion',
    version = false,
    cond = _G.kernel.opts.plugins.completion == 'minicompletion',
    event = { 'InsertEnter', 'LspAttach' },
    config = require('plugins.configs.minicompletion'),
  },

  -- Formatters and Linters
  {
    'nvimdev/guard.nvim',
    event = { 'LspAttach', 'VeryLazy' },
    -- Builtin configuration, optional
    dependencies = {
      'nvimdev/guard-collection',
    },
    config = require('plugins.configs.guard'),
  },

  -- Trouble
  {
    'folke/trouble.nvim',
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = 'Trouble',
  },

  -- Saga
  {
    'nvimdev/lspsaga.nvim',
    event = 'LspAttach',
    dependencies = {
      'nvim-treesitter/nvim-treesitter', -- optional
      'nvim-tree/nvim-web-devicons',     -- optional
    },
    config = require('plugins.configs.saga'),
  },

  -- Signature managment
  {
    'ray-x/lsp_signature.nvim',
    event = 'VeryLazy',
    opts = {
      -- hint_prefix = "🐼 ", -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
      -- or, provide a table with 3 icons
      hint_prefix = {
        above = "↙ ", -- when the hint is on the line above the current line
        current = "← ", -- when the hint is on the same line
        below = "↖ " -- when the hint is on the line below the current line
      },
      handler_opts = {
        border = "rounded" -- double, rounded, single, shadow, none, or a table of borders
      },

    },
    config = function(_, opts)
      require('lsp_signature').setup(opts)
    end,
  },
}
