--- Load the global configs
require('globals')
--- Load las opts
require('core.options')
-- Load events
require('core.events')

--- Maps
vim.g.mapleader = ' ' -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = ' ' -- Same for `maplocalleader`

require('internal.keys')
-- Bootstrap plugins
require('bootstrap.lazy')
-- require('bootstrap.mini-deps')

-- LSP

-- Events to execute when the plugins boostraping
vim.api.nvim_create_autocmd({ 'User' }, {
  pattern = { 'PostPlugins' },
  callback = function(args)
    -- aditional filetype event on verylazy

    vim.api.nvim_exec_autocmds('FileType', {})

    local lazy_loads = {
      -- 'keys',
      -- 'events',
      'status',
      'lsp',
    }
    for _, file in pairs(lazy_loads) do
      require('internal.' .. file)
    end
  end,
})

vim.cmd.colorscheme(_G.globals.colorscheme)
