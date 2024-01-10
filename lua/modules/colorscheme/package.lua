local package = require('core.pack').package
local conf = require('modules.colorscheme.config')

local colorscheme = 'ronny'

-- Kanagawa
package({
  enabled = colorscheme == 'kanagawa',
  'rebelot/kanagawa.nvim',
  priority = 1000,
  lazy = false,
  config = conf.kanagawa,
})

-- Cyberdream -- not gerat
package({
  enabled = colorscheme == 'cyberdream',
  'scottmckendry/cyberdream.nvim',
  priority = 1000,
  lazy = false,
  config = conf.cyberdream,
})

-- Night owl
package({
  enabled = colorscheme == 'night-owl',
  'oxfist/night-owl.nvim',
  priority = 1000,
  lazy = false,
  config = conf.night_owl,
})

--  Monokai nightasty
package({
  enabled = colorscheme == 'monokai-nightasty',
  'polirritmico/monokai-nightasty.nvim',
  priority = 1000,
  lazy = false,
  config = conf.monokai_nightasty,
})

-- Ronny
package({
  enabled = colorscheme == 'ronny',
  'judaew/ronny.nvim',
  priority = 1000,
  lazy = false,
  config = conf.ronny,
})
