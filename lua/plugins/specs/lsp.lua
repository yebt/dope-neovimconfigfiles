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

  --- LSP
  {
    'neovim/nvim-lspconfig',
    evets = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    dependencies = {
      {
        'williamboman/mason.nvim',
        opts = {
          ui = {
            icons = {
              package_installed = '✓',
              package_pending = '➜',
              package_uninstalled = '✗',
            },
          },
        },
      },
      {
        'williamboman/mason-lspconfig.nvim',
        config = function() end,
      },
    },
    config = require('plugins.configs.lspc'),
  },

  --- Servers
  -- {
  --   ""
  -- },
  --- Completions
  --- Formatter
  --- LSPSaga
}
