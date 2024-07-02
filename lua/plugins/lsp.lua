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
    event = { 'InsertEnter', 'LspAttach' },
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
}
