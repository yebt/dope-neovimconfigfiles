-- help to search
return {
  -- Pickers
  {
    "echasnovski/mini.pick",
    version = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      { "echasnovski/mini.extra", version = false },
      { "echasnovski/mini.visits", version = false },
    },
    init = function()
      vim.ui.select = function(...)
        local MiniPick = require("mini.pick")
        vim.ui.select = MiniPick.ui_select
        vim.ui.select(...)
      end
    end,
    cmd = { "Pick" },
    keys = {
      { "<C-p>", "<cmd>Pick files<cr>", desc = "Pick files" },
      { "<m-x>", "<cmd>Pick buffers<cr>", desc = "Pick visit path" },
      -- { '<C-p>', '<cmd>Pick files<cr>', desc = 'Pick files' },
    },
    config = require("plugins.configs.minipick"),
  },

  -- Fuzzi
  -- {
  --   'echasnovski/mini.fuzzy',
  --   version = false,
  --   config = require("plugins.confgis.minifuzzy")
  -- },
}
