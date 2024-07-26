--  HERE: Plugins to make like a IDE or editor experience
return {

  -- Iterator
  {
    'folke/trouble.nvim',
    cmd = { 'Trouble' },
    config = require('plugins.configs.troublec'),
  },
}
