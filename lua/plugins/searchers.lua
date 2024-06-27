-- help to search
return {
  {
    'echasnovski/mini.pick',
    version = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      { 'echasnovski/mini.extra', version = false },
      { 'echasnovski/mini.visits', version = false },
    },
    init = function()
      vim.ui.select = function(...)
        local MiniPick = require('mini.pick')
        vim.ui.select = MiniPick.ui_select
        vim.ui.select(...)
      end
    end,
    cmd = { 'Pick' },
    keys = {
      { '<C-p>', '<cmd>Pick files<cr>', desc = 'Pick files' },
    },
    config = require('plugins.configs.minipick'),
  },
}
