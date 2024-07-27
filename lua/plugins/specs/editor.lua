--  HERE: Plugins to make like a IDE or editor experience
local selected_plugin = require('util.functions').selected_plugin
return {

  -- Iterator
  {
    'folke/trouble.nvim',
    cmd = { 'Trouble' },
    config = require('plugins.configs.troublec'),
  },

  -- Session Manager
  {
    'echasnovski/mini.sessions',
    version = false,
    cond = selected_plugin('sessions','minisessions'),
    config = require('plugins.configs.minisessionsc'),
  },
}
