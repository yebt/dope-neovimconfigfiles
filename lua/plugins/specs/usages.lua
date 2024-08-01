-- Plugins to make a better usage
return {

  --- Align
  {
    'echasnovski/mini.align',
    version = false,
    keys = {
      { 'ga', mode = { 'n', 'x' } },
      { 'gA', mode = { 'n', 'x' } },
    },
    config = require('plugins.configs.minialignc'),
  },

  --- Which Key
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        '<leader>?',
        function()
          require('which-key').show({ global = false })
        end,
        desc = 'Buffer Local Keymaps (which-key)',
      },
    },
  },

  --- Remove buffer
  {
    'echasnovski/mini.bufremove',
    version = false,
    keys = {
      {
        '<M-c>',
        function()
          MiniBufremove.delete()
        end,
      },
    },
    opts = {
      -- Whether to set Vim's settings for buffers (allow hidden buffers)
      set_vim_settings = true,

      -- Whether to disable showing non-error feedback
      silent = false,
    },
  },
}
