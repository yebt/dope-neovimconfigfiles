local package = require('core.pack').package
local conf = require('modules.colorscheme.config')

local colorscheme = 'vitesse'

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

-- NvimGelion
package({
  enabled = colorscheme == 'nvimgelion',
  'nyngwang/nvimgelion',
  priority = 1000,
  lazy = false,
  config = conf.nvimgelion,
})

-- Everblush
package({
  enabled = colorscheme == 'everblush',
  'Everblush/nvim',
  name = 'everblush',
  priority = 1000,
  lazy = false,
  config = conf.everblush,
})

-- Aquarium
package({
  enabled = colorscheme == 'aquarium',
  'FrenzyExists/aquarium-vim',
  priority = 1000,
  lazy = false,
  config = conf.aquarium,
})

-- Catppuccin
package({
  enabled = colorscheme == 'catppuccin',
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  lazy = false,
  config = conf.catppuccin,
})

-- Vitesse
package({
  enabled = colorscheme == 'vitesse',
  '2nthony/vitesse.nvim',
  dependencies = {
    'tjdevries/colorbuddy.nvim',
  },
  priority = 1000,
  lazy = false,
  config = conf.vitesse,
})

-- Tokyonight
package({
  enabled = colorscheme == 'tokyonight',
  'folke/tokyonight.nvim',
  priority = 1000,
  lazy = false,
  config = conf.tokyonight,
})
