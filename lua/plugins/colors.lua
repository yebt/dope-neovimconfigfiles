return {
  {
    'folke/tokyonight.nvim',
    config = require('plugins.configs.tokyonight'),
    -- lazy = false, -- make sure we load this during startup if it is your main colorscheme
    -- priority = 1000, -- make sure to load this before all the other start plugins
    -- config = function()
    --   -- load the colorscheme here
    --   vim.cmd([[colorscheme tokyonight]])
    -- end,
  },
  {
    'NLKNguyen/papercolor-theme',
  },
  {
    '2nthony/vitesse.nvim',
    dependencies = {
      'tjdevries/colorbuddy.nvim',
    },
  },
  {
    "craftzdog/solarized-osaka.nvim",
  },
  {
    "marko-cerovac/material.nvim"
  },
  {
    "loctvl842/monokai-pro.nvim",
    config = require("plugins.configs.monokaipro")
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = require("plugins.configs.catppuccin")
  }

}
