return {

  {
    -- Lsp config wrapper
    'neovim/nvim-lspconfig',
    event = { 'VeryLazy' },
    dependencies = {},
    config = require('plugins.configs.lsp'),
  },
  -- Lsp servers
  {
    'williamboman/mason.nvim',
    lazy = false,
    cmd = {
      'Mason',
      'MasonUpdate',
      'MasonInstall',
      'MasonUninstall',
      'MasonUninstallAll',
      'MasonLog',
    },
    -- build=":MasonUpdate"
    build = function()
      require('mason')
      require('mason-registry').update(function(success)
        vim.notify('registry updated')
      end)
    end,
  },
  -- Bridge lspconfig and mason
  {
    'williamboman/mason-lspconfig.nvim',
  },
}
