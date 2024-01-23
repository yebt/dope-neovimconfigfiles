-- Imports
-----------------------------------

local map = require('core.keymap')
local cmd = map.cmd
local vcmd = vim.cmd
local vfn = vim.fn
local vapi = vim.api

--- Helper Functions
-----------------------------------

-- Helper function to escape file name for search
function escape_fname(fname)
  return vfn.escape(fname, '\\/.*$^~[]')
end

-- Delay for Netrw to open and load the file list
function search_name(current_file)
  vfn.search(escape_fname(vim.fn.fnamemodify(current_file, ':t')), 'W')
  -- vim.defer_fn(function()
  --   vim.fn.search(escape_fname(vim.fn.fnamemodify(current_file, ':t')), 'W')
  -- end, 100)
end

--- Action Functions
-----------------------------------

-- Toggle netrw
function toggleNetrw()
  local explorer_command = 'Lex! %:p:h'
  -- local explorer_command = 'Lex %:p:h'
  -- local explorer_command = 'Vex %:p:h'
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

-- Imports
-----------------------------------

vim.keymap.set('n', '\\', toggleNetrw, { silent = true, noremap = true, desc = 'Toggle netrw' })

-- Todo
-----------------------------------
-- netrw-usermaps
-- netrw_preview
-- netrw_alto
--
vim.g.netrw_silen=1
vim.g.netrw_use_errorwindow=2

vim.g.netrw_banner=0 -- supress the banner
vim.g.netrw_bannerbackslash=0
-- 0 (reuse the same window),
-- 1(horizontal split)
-- 2(vertical)
-- 3(tab)
-- 4(preview)
vim.g.netrw_browse_split=2
vim.g.netrw_list_hide=vim.fn["netrw_gitignore#Hide"]()
 -- 0:notes,1:warning,2:errors
vim.g.netrw_errorlbl=0
vim.g.netrw_fastbrowse=0
vim.g.netrw_hide=0
vim.g.netrw_keepdir=1
-- 0(thin list one file perline)
-- 1(long list one file perline)
-- 2(wide lirt multiple files in line)
-- 3(tree style)
vim.g.netrw_liststyle=3

--- Todo
-- [ ] Implement the Rexplore (Return to netrw if a file is open from netre, return to file if netrw is open
-- from file)

--- Maps:
-- qf   ->  file info

--- Commands:
-- du -sh file   ->  file size
