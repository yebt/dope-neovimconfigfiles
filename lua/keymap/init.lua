-- require('keymap.remap')
local map = require('core.keymap')
local cmd = map.cmd

---------------
--- Functions
---------------

function homeVsKey()
  local col = vim.fn.col('.')
  local line = vim.api.nvim_get_curent_line()
  local no_blank_col = vim.fn.match(line, '\\S') + 1
  return col == no_blank_col and 'g0' or '^'
end

function brem()

end
