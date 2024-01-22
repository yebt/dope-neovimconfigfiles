-- require('keymap.remap')
local map = require('core.keymap')
local cmd = map.cmd
local vcmd = vim.cmd
local vfn = vim.fn
local vapi = vim.api

--------------------
--- Helper Functions
--------------------

-- Helper function to escape file name for search
function escape_fname(fname)
  return vim.fn.escape(fname, '\\/.*$^~[]')
end

-- Delay for Netrw to open and load the file list
function search_name(current_file)
    vim.fn.search(escape_fname(vim.fn.fnamemodify(current_file, ':t')), 'W')
  -- vim.defer_fn(function()
  --   vim.fn.search(escape_fname(vim.fn.fnamemodify(current_file, ':t')), 'W')
  -- end, 100)
end

---------------
--- Functions
---------------

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

-- Helper fucntio to

-- Toggle netrw
function toggleNetrw()
  local explorer_command = 'Vex %:p:h'
  -- local explorer_command = 'Ex %:p:h'
  local current_buf = vapi.nvim_get_current_buf()
  local current_file = vim.fn.expand('%')

  -- Close netrw
  if vapi.nvim_buf_get_option(0, 'filetype') == 'netrw' then
    vcmd('bd')
    return
  end

  -- Buscar buffer to focus
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.api.nvim_buf_get_option(buf, 'filetype') == 'netrw' then
      vim.api.nvim_set_current_win(win)
      search_name(current_file)
      return
    end
  end

  vcmd(explorer_command)
  search_name(current_file)

end

vim.keymap.set('n', '\\', toggleNetrw, { silent = true, noremap = true, desc = 'Toggle netrw' })
