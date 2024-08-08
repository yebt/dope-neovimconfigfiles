--- ----------------------------------------
--- Colorschemes to use
--- ----------------------------------------

-- local colorscheme = 'kanagawa.nvim'
local colorscheme = 'tokyonight.nvim'

function is_color(plgn)
  return plgn.name == colorscheme
end

return {
  --- Mini base 16
  {
    'echasnovski/mini.base16',
    cond = is_color,
    version = false,
  },

  --- Vitesse
  {
    '2nthony/vitesse.nvim',
    cond = is_color,
    dependencies = {
      'tjdevries/colorbuddy.nvim',
    },
  },

  --- Creation
  -- {
  --   'rktjmp/lush.nvim',
  --   cmd = { 'LushRunTutorial', 'Lushify' },
  -- },

  --- Tokyo
  {
    'folke/tokyonight.nvim',
    cond = is_color,
    lazy = false,
    priority = 1000,
    config = require('plugins.configs.tokyonightc'),
  },

  --- Space duck
  -- {
  --   'spaceduck-theme/nvim',
  --   name = 'spaceduck-nv',
  -- },
  -- {
  --   'pineapplegiant/spaceduck',
  -- },

  --- Kanagawa
  {
    'rebelot/kanagawa.nvim',
    cond = is_color,
    lazy = false,
    priority = 1000,
    config = require('plugins.configs.kanagawac'),
  },
}
