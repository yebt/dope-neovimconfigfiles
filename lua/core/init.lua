--- Load the global configs
require('globals')
--- Load las opts
require('core.options')
-- Load events
require('core.events')

vim.api.nvim_create_autocmd({ 'User' }, {
  pattern = { 'PostPlugins' },
  callback = function(args)
    local lazy_loads = {
      'keys',
      -- 'events',
      'status',
    }
    for _, file in pairs(lazy_loads) do
      require('internal.' .. file)
    end
  end,
})

--- Maps
vim.g.mapleader = ' ' -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = ' ' -- Same for `maplocalleader`

-- Load lazy vim
-- require('bootstrap.lazy')
-- require('bootstrap.mini-deps')

vim.cmd.colorscheme(_G.globals.colorscheme)
