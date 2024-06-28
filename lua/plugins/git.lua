-- Git features
return {
  -- -- mini git
  -- {
  --   'echasnovski/mini-git',
  --   version = false,
  --   main = 'mini.git',
  --   config = require('plugins.configs.minigit'),
  -- },
  --
  -- -- signs
  -- {
  --   'echasnovski/mini.diff',
  --   version = false,
  --   event = 'VeryLazy',
  --   config = require('plugins.configs.minidiff'),
  -- },

  -- Signs
  {
    "lewis6991/gitsigns.nvim",
    event = 'VeryLazy',
    config = require("plugins.configs.gitsigns")
  }

}
