-- HERE: Make a better ui
local selected_plugin = require('util.functions').selected_plugin
return {

  -- Dressing for input
  {
    'stevearc/dressing.nvim',
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require('lazy').load({ plugins = { 'dressing.nvim' } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require('lazy').load({ plugins = { 'dressing.nvim' } })
        return vim.ui.input(...)
      end
    end,
  },

  -- Fold Column
  {
    'yaocccc/nvim-foldsign',
    lazy = false,
    cond = selected_plugin('foldcolumn', 'sign'),
    opts = {
      offset = -2,
      foldsigns = {
        open = '-', -- mark the beginning of a fold
        close = '+', -- show a closed fold
        seps = { '│' }, -- open fold middle marker
      },
    },
  },
}
