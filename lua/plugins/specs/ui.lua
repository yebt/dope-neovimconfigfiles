--- ----------------------------------------
--- UI managment
--- ----------------------------------------

return {

  --- Notifications
  {
    'echasnovski/mini.notify',
    version = false,
    lazy = false, -- load in core
    config = require('plugins.configs.mininotifyc'),
  },

  --- statusline
  -- {
  --   'nvim-lualine/lualine.nvim',
  --   event = 'VeryLazy',
  --   priority = 1000,
  --   dependencies = { 'nvim-tree/nvim-web-devicons' },
  --   config = require('plugins.configs.lualinec')
  -- }
}
