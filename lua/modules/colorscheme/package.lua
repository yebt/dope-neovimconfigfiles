local package = require('core.pack').package
local conf = require('modules.colorscheme.config')

local colorscheme = 'kanagawa'

-- Kanagawa
package({
  enabled = colorscheme == 'kanagawa',
  'rebelot/kanagawa.nvim',
  priority = 1000,
  lazy = false,
  config = conf.kanagawa,
})
