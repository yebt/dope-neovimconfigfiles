--- Other maps
------------------------
require('keymap.netrw')

--- Requires
------------------------

-- require('keymap.remap')
local map = require('core.keymap')
local cmd = map.cmd
local vcmd = vim.cmd
local vfn = vim.fn
local vapi = vim.api

--- Helper Functions
--------------------

--- Functions
--------------------

--- Home key like vscode
function homeVsKey()
  local col = vfn.col('.')
  local line = vapi.nvim_get_curent_line()
  local no_blank_col = vfn.match(line, '\\S') + 1
  return col == no_blank_col and 'g0' or '^'
end

--- Buffer remove
function brem()
  if vfn.winnr('$') < 2 then
    vcmd('bw')
    return
  elseif vfn.bufnr('$') < 2 then
    vim.cmd('enew')
  end
  vim.cmd('bn | bw #')
end
