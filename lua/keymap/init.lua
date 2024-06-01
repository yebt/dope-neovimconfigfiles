----------------------------------
--- This file contain maps
----------------------------------
--require('keymap.remap')
local map = require('core.keymap_api')
local cmd = map.cmd

map.n({
  ['<C-z>'] = '',
})

map.n({
  ['<leader>q'] = cmd('q'),
  ['<leader>w'] = cmd('w'),
}, { silent = true })
