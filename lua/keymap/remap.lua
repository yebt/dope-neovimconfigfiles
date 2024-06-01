----------------------------------
--- This file contain the remaps
----------------------------------

local api = vim.api
local map = require('core.keymap_api')
local cmd = map.cmd

-- Unmap
map.n({
  ['<C-z>'] = '',
})

-- Normal
map.n({
  ['<M-w>'] = cmd('w'),
  ['<M-q>'] = cmd('q'),
}, { silent = true })

-- map.n({
--   -- ['j'] = 'gj',
--   -- ['k'] = 'gk',
--   ['<M-w>'] = cmd('write'),
--   ['<M-q>'] = cmd('q'),
--   --['<C-x>k'] = cmd(vim.bo.buftype == 'terminal' and 'q!' or 'bdelete!'),
--   --['<C-n>'] = cmd('bn'),
--   --['<C-p>'] = cmd('bp'),
--   --['<C-q>'] = cmd('qa!'),
--   ----window
--   --['<C-h>'] = '<C-w>h',
--   --['<C-l>'] = '<C-w>l',
--   --['<C-j>'] = '<C-w>j',
--   --['<C-k>'] = '<C-w>k',
--   --['<A-[>'] = cmd('vertical resize -5'),
--   --['<A-]>'] = cmd('vertical resize +5'),
--   --['[t'] = cmd('vs | vertical resize -5 | terminal'),
--   --[']t'] = cmd('set splitbelow | sp | set nosplitbelow | resize -5 | terminal'),
--   --['<C-x>t'] = cmd('tabnew | terminal'),
-- })
