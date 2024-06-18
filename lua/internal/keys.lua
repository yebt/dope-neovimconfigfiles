local fns = require('utils.functions')
local mps = vim.keymap.set

--- Usage
-- motion
mps('n', '0', fns.homeVsKey, { silent = true, expr = true })
-- register
mps('n', '<leader>q', ':q<CR>', { silent = true, desc = 'Quit of nvim' })
mps('n', '<leader>w', ':w<CR>', { silent = true, desc = 'Save buffer' })
-- same stop with ctrl+c
mps({ 'x', 'i', 'n' }, '<C-c>', '<ESC>', { silent = true, desc = 'Stop on esc' })
-- select all
mps('n', '<leader>a', 'ggVG', { silent = true, desc = 'select all content' })
-- yanc
mps('x', '<leader>y', '"+y', { silent = true, desc = 'Copy selection insude clipboard' })
mps('n', '<leader>Y', '"+y$', { silent = true, desc = 'Copy from position forward' })
mps('n', '<leader>yy', '"+yy', { silent = true, desc = 'Copy the lines' })
-- NoH
mps({ 'n', 'x' }, '<leader>h', ':noh<CR>', { silent = true, desc = 'Toggle highlight of search' })

--- Edit
mps('n', '[<space>', fns.blank_above, { silent = true, desc = 'Blank above' })
mps('n', ']<space>', fns.blank_below, { silent = true, desc = 'Blank below' })
mps('x', '<leader>p', '"_dP', { silent = true, desc = 'Paste without losee content' })
-- indent
mps('x', '<', '<gv', { silent = true, desc = 'Indent -' })
mps('x', '>', '>gv', { silent = true, desc = 'Indebt +' })
mps('v', 'J', ":m '>+1<CR>gv=gv", { silent = true, desc = 'Move selection up' })
mps('v', 'K', ":m '<-2<CR>gv=gv", { silent = true, desc = 'Move selection down' })
-- surround
mps('x', '<C-s>', fns.surround, { silent = true, expr = true, desc = 'Add surround' })
-- Replace cursor word
mps(
  'n',
  '<leader>s',
  ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>',
  { desc = 'Remplace cursor word, in all document' }
)

--- Views
-- splits
mps('n', '<M-Bar>', ':vsplit<cr>', { silent = true, desc = 'Vertical split' })
mps('n', '<M-->', ':split<cr>', { silent = true, desc = 'Horizontal split' })
-- netrw
mps('n', '\\', fns.toggleNetrw, { silent = true, desc = 'Toggle netrw' })
-- Toggle wrap
mps('n', '<M-z>w', ':set wrap!<CR>', { silent = true, desc = 'Toggle wrap' })

--- Buffer
-- Move beetween splits
mps('n', '<M-h>', '<C-w>h', { silent = true, desc = 'Move to left split' })
mps('n', '<M-l>', '<C-w>l', { silent = true, desc = 'Move to right split' })
mps('n', '<M-k>', '<C-w>k', { silent = true, desc = 'Move to up split' })
mps('n', '<M-j>', '<C-w>j', { silent = true, desc = 'Move to down split' })
-- Move trough buffers
mps('n', '<M-d>', ':bn<cr>', { silent = true, desc = 'Go to next buffer' })
mps('n', '<M-a>', ':bp<cr>', { silent = true, desc = 'Go to prev buffer' })
mps('n', '<M-s>', ':b#<cr>', { silent = true, desc = 'Go to # buffer' })
-- Remove buffer
mps('n', '<M-c>', fns.brem, { silent = true, desc = 'Delete buffer' })

--- Terminal
-- escape
mps('t', '<ESC>', '<C-\\><C-n>', { silent = true, desc = 'Exit terminal mode' })
