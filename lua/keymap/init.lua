----------------------------------
--- This file contain maps
----------------------------------
--require('keymap.remap')
local fns = require('internal.functions')
local kap = require('core.keymap_api')
local map = vim.keymap.set
local bmap = vim.api.nvim_buf_set_keymap
-- local cmd = map.cmd
local cmd = function(str)
  return '<cmd>' .. str .. '<CR>'
end

-- Unmap
kap.n({ ['<C-z>'] = '' })

-- Usage
map({ 'n' }, '<leader>q', cmd('q'), { silent = true, desc = 'Close panel' })
map({ 'n' }, '<leader>w', cmd('w'), { silent = true, desc = 'Write buffer' })
map({ 'n', 'x', 'i' }, '<c-c>', '<esc>', { silent = true, desc = 'Ctrl-c like esc' })
map({ 'n' }, '<leader>a', 'ggVG', { silent = true, desc = 'Select all' })

map({ 'n' }, '\\', fns.toggleNetrw , { silent = true, desc = 'Toggle netrw' })

-- Editing
map({ 'n' }, '[<space>', fns.blank_above, { silent = true, desc = 'Add space above' })
map({ 'n' }, ']<space>', fns.blank_below, { silent = true, desc = 'Add space below' })
map({ 'n' }, '<leader>p', '"_dP', { silent = true, desc = 'Paste with lose the conent' })

map({ 'x' }, '<leader>y', '"+y"', { silent = true, desc = 'Yank selection on unnamedplus clipboard' })
map({ 'n' }, '<leader>Y', '"+y$"', { silent = true, desc = 'Yank to end of line' })
map({ 'n' }, '<leader>yy', '"+yy"', { silent = true, desc = 'Copy line' })

map({ 'x' }, '<', '<gv', { silent = true, desc = 'Indent -' })
map({ 'x' }, '>', '>gv', { silent = true, desc = 'Indent +' })

map({ 'v' }, 'K', ":m '>-2<CR>gv=gv", { silent = true, desc = 'Move selection up' })
map({ 'v' }, 'J', ":m '>+1<CR>gv=gv", { silent = true, desc = 'Move selection down' })

map({ 'x' }, '<c-s>', fns.vsurround, { silent = true, expr = true, desc = 'Add the surround around selection' })


map({ 'n' }, '<leader>s', ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>" , { silent = true, desc = 'Replace cursor word in document' })


-- Motions
map({ 'n' }, '0', fns.homeVsKey , { silent = true, desc = 'Home key' })

-- buffers
map({ 'n' }, '<M-c>', fns.brem, { silent = true, desc = 'Remove buffer' })

kap.n({
  ['<M-a>'] = cmd('bp'),
  ['<M-d>'] = cmd('bn'),
  ['<M-s>'] = cmd('b#'),
}, { silent = true, desc = 'Move around the buffers' })

-- View
map({ 'n' }, '<M-Bar>', cmd('vs'), { silent = true })
map({ 'n' }, '<M-->', cmd('sp'), { silent = true })

-- Move in splits
kap.n({
  ['<M-h>'] = '<C-w>h',
  ['<M-l>'] = '<C-w>l',
  ['<M-k>'] = '<C-w>k',
  ['<M-j>'] = '<C-w>j',
}, { silent = true, desc = 'Move around splits' })

-- Terminal
kap.t({
  ['<ESC>'] = '<C-\\><C-n>',
}, { silent = true })
