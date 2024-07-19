return {
  -- Autopairing
  {
    'echasnovski/mini.pairs',
    version = false,
    keys = {
      { '(', mode = 'i' },
      { ')', mode = 'i' },
      { '{', mode = 'i' },
      { '}', mode = 'i' },
      { '[', mode = 'i' },
      { ']', mode = 'i' },
      { "'", mode = 'i' },
      { '`', mode = 'i' },
      { '"', mode = 'i' },
    },
    -- lazy = false,
    config = require('plugins.configs.minipairs'),
  },

  -- Todo comments
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = { 'TodoTrouble' },
    event = "VeryLazy",
    config = require('plugins.configs.todocomments'),
  },
}
