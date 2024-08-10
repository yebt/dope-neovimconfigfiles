--- ----------------------------------------
--- Core usage
--- ----------------------------------------
return {
  --- Better practices in the usage
  {
    'm4xshen/hardtime.nvim',
    dependencies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
    lazy = false,
    config = require('plugins.configs.hardtimec'),
  },

  --- Syntax Highlight
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'LazyFile', 'VeryLazy' },
    cmd = function()
      return { 'TSUpdateSync', 'TSUpdate', 'TSInstall' }
    end,
    keys = {
      { '<c-space>', desc = 'Increment Selection' },
      { '<bs>', desc = 'Decrement Selection', mode = 'x' },
    },
    config = require('plugins.configs.treesitterc'),
  },

  --- Text Objects
  -- {
  --   'nvim-treesitter/nvim-treesitter-textobjects',
  --   event = 'VeryLazy',
  -- },
}
