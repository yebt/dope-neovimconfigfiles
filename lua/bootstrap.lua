--- ----------------------------------------
--- Here control the boot strapping of the
--- neovim and the order of the load the
--- files
--- ----------------------------------------

--- Load options
require('configs.options')

--- Load autocmd
--- Autocmds can be loaded lazily when not opening a file
local without_args = vim.fn.argc(-1) == 0
if not without_args then
  require('configs.autocmds')
end

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

--- Allow the keymaps from the plugins overwrite the actions
require('configs.keymaps')

--- Load autocmd
require('configs.autocmds')

vim.api.nvim_create_autocmd('User', {
  group = group,
  pattern = 'VeryLazy',
  callback = function()
    if without_args then
      require('configs.autocmds')
    end
  end,
})

--- Load package manager
-- require('minideps') -- I don't like
require('lazynvim')
