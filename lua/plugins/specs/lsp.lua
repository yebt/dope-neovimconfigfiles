-- Try to habilitate the lsp control
return {
  --- Completion
  {
    'hrsh7th/nvim-cmp',
    version = false, -- last release is way too old
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      --
      'onsails/lspkind.nvim',
    },
    config = require('plugins.configs.nvimcmpc'),
  },

  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason.nvim',
    },
    config = require('plugins.configs.lspc'),
  },

  --- Servers
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    keys = { { '<leader>cm', '<cmd>Mason<cr>', desc = 'Mason' } },
    build = ':MasonUpdate',
    opts = {
      ui = {
        icons = {
          package_installed = '0k',
          package_pending = '»',
          package_uninstalled = '#',
        },
      },
    },
    config = require('plugins.configs.masonc'),
  },

  --- Servers Bridge
  {
    'williamboman/mason-lspconfig.nvim',
    opts = {
      ensure_installed = {},
    },
    config = require('plugins.configs.masonlspc'),
  },

  --- --- LSP
  --- {
  ---   'neovim/nvim-lspconfig',
  ---   event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
  ---   dependencies = {
  ---     {
  ---       'williamboman/mason.nvim',
  ---       opts = {
  ---         ui = {
  ---           icons = {
  ---             package_installed = '✓',
  ---             package_pending = '➜',
  ---             package_uninstalled = '✗',
  ---           },
  ---         },
  ---       },
  ---     },
  ---     {
  ---       'williamboman/mason-lspconfig.nvim',
  ---       -- config = function() end,
  ---     },
  ---   },
  ---   config = require('plugins.configs.lspc'),
  --- },
  -- {
  --   'neovim/nvim-lspconfig',
  --   evets = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
  --   dependencies = {
  --     {
  --       'williamboman/mason.nvim',
  --       opts = {
  --         ui = {
  --           icons = {
  --             package_installed = '✓',
  --             package_pending = '➜',
  --             package_uninstalled = '✗',
  --           },
  --         },
  --       },
  --     },
  --     {
  --       'williamboman/mason-lspconfig.nvim',
  --       config = function() end,
  --     },
  --   },
  --   config = require('plugins.configs.lspc'),
  -- },

  --- Servers
  -- {
  --   ""
  -- },
  --- Completions
  --- Formatter
  --- LSPSaga
}
