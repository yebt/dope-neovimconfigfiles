local keymap = require('core.keymap')
local nmap, imap, cmap, xmap, tmap = keymap.nmap, keymap.imap, keymap.cmap, keymap.xmap, keymap.tmap
local silent, noremap, expr = keymap.silent, keymap.noremap, keymap.expr
local opts = keymap.new_opts
local cmd = keymap.cmd

local map = vim.keymap.set

---------------
--- Functions
---------------

-- Home
local homeVsKey = function()
  local col = vim.fn.col('.')
  local line = vim.api.nvim_get_current_line()
  local nonBlankColumn = vim.fn.match(line, '\\S') + 1
  if col == nonBlankColumn then
    action = 'g0'
  else
    action = '^'
  end
  return action
end

-- Remove buffer
local brem = function()
  -- if there are less than 2
  if vim.fn.winnr('$') < 2 then
    vim.cmd('bw')
    return
  end
  -- there are at least 2 windows
  -- if there are less that 2 buffers
  if vim.fn.bufnr('$') < 2 then
    vim.cmd('enew')
  end
  vim.cmd('bn |  bw #')
end

-- Toggle netrw
local toggleNetrw = function()
  -- Verificar si el buffer de netrw ya está abierto
  local netrw_buf_exists = false
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_get_option(buf, 'filetype') == 'netrw' then
      netrw_buf_exists = true
      break
    end
  end

  -- Abrir Vexprore si el buffer de netrw no está abierto
  if not netrw_buf_exists then
    --vim.cmd("Vexplore")
    vim.cmd('Explore %:p:h')
  else
    -- Obtener el número del buffer actual
    local current_buf = vim.api.nvim_get_current_buf()

    -- Verificar si el buffer actual es netrw
    if vim.api.nvim_buf_get_option(current_buf, 'filetype') == 'netrw' then
      -- Cerrar el buffer actual
      vim.cmd('bd')
    else
      -- Enfocar el buffer de netrw
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.api.nvim_buf_get_option(buf, 'filetype') == 'netrw' then
          vim.api.nvim_set_current_win(win)
          break
        end
      end
    end
  end
end

---------------
--- Maps
---------------

-- Use space as leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- leaderkey
nmap({ ' ', '', opts(noremap) })
xmap({ ' ', '', opts(noremap) })

---------------
-- Regular maps
---------------

-- Multiple maps
map({ 'x', 'i', 'n' }, '<C-c>', '<ESC>', { silent = true, desc = 'Stop on ESC' })

map('n', '\\', toggleNetrw, { silent = true, desc = 'Toggle netrw' })

nmap({
  { '0', homeVsKey, opts(silent, noremap, expr, 'Home key like vscode') },
  { '<leader>q', cmd('q'), opts(silent, noremap, 'Quit of vim') },
  { '<leader>w', cmd('w'), opts(silent, noremap, 'Save file') },
  -- Splits
  { '<M-Bar>', cmd('vsplit'), opts(silent, noremap, 'Vertical Split') },
  { '<M-->', cmd('split'), opts(silent, noremap, 'Horizontal Split') },
  -- Move between splits
  { '<M-l>', 'l', opts(silent, noremap, 'Move to Right split') },
  { '<M-h>', 'h', opts(silent, noremap, 'Move to Left split') },
  { '<M-k>', 'k', opts(silent, noremap, 'Move to Up split') },
  { '<M-j>', 'j', opts(silent, noremap, 'Move to Down split') },
  -- Move between buffers
  { '<M-d>', cmd('bn'), opts(silent, noremap, 'Go to Next buffer') },
  { '<M-a>', cmd('bp'), opts(silent, noremap, 'Go to Prev buffer') },
  { '<M-s>', cmd('b#'), opts(silent, noremap, 'Go to Last buffer') },
  -- Remove buffer
  { '<M-c>', brem, opts(silent, noremap, 'Delete the buffer') },
  -- Select all
  { '<leader>a', 'ggVG', opts(silent, noremap, 'Select all content') },
  -- Paste
  { '<leader>p', '"_dP', opts(silent, noremap, 'Paste without lose content') },
  -- Yank on system clipboard
  { '<leader>Y', '"+y$', opts(silent, noremap, 'Copy the content from the position to end of line on clipboard') },
  { 'Y', 'y$', opts(silent, noremap, 'Copy the content from the position to end of line') },
  { '<leader>yy', '"+yy', opts(silent, noremap, 'Copy the line content on the system clipboard') },
  -- Surround
  -- Toggler
  { '\\', toggleNetrw, opts(silent, noremap, 'Toggle netrw') },
  -- Repalce
  { '<leader>s', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>', opts(silent, noremap, 'Replace word') },
  -- Toggle wrap mode
  { '<M-z>w', cmd('set wrap!'), opts(silent, noremap, 'Toggle wrap') },
  -- Noh
  { '<leader>h', cmd('noh'), opts(silent, noremap, 'Search off') },
})

xmap({
  -- Yank on system clipboard
  { '<leader>y', '"+y', opts(silent, noremap, 'Yank visual select in system clipboard') },
  -- Indentation
  { '>', '>gv', opts(silent, noremap, 'Increase Indentation') },
  { '<', '<gv', opts(silent, noremap, 'Decreacrease Indentation') },
  -- Move selected lines
  { 'J', ":m '>+1<CR>gv=gv", opts(silent, noremap, 'Moce line down') },
  { 'K', ":m '<-2<CR>gv=gv", opts(silent, noremap, 'Moce line up') },
  -- Force surroudns
  {
    '<C-s>',
    function()
      local char_code = vim.fn.getchar()
      local char = vim.fn.nr2char(char_code)
      if char == '\x03' or char == '\x1b' then
        return
      end
      local surrounds = {
        ['('] = ')',
        ['['] = ']',
        ['{'] = '}',
        ['<'] = '>',
        -- ' " ` = are the same
      }
      local pair_char = surrounds[char] or char
      return 'c' .. char .. '<C-r><C-o>"' .. pair_char .. '<ESC><Left>vi' .. char
    end,
    opts(silent, expr, 'Force surrounds'),
  },
})

imap({
  { '<C-h>', '<Bs>', opts(noremap) },
  { '<C-e>', '<End>', opts(noremap) },
})

tmap({ '<ESC>', '<C-\\><C-n>', opts(silent, noremap, 'Exist of terminal mode') })

-- usage of plugins
nmap({
  -- Lazy.nvim
  { '<leader>lu', cmd('Lazy update'), opts(noremap, silent, 'Lazy update') },
  { '<leader>lp', cmd('Lazy profile'), opts(noremap, silent, 'Lazy profile') },
  -- -- plugin manager: Lazy.nvim
  -- { '<Leader>pu', cmd('Lazy update'), opts(noremap, silent) },
  -- { '<Leader>pi', cmd('Lazy install'), opts(noremap, silent) },
  -- -- dashboard
  -- { '<Leader>n', cmd('DashboardNewFile'), opts(noremap, silent) },
  -- { '<Leader>ss', cmd('SessionSave'), opts(noremap, silent) },
  -- { '<Leader>sl', cmd('SessionLoad'), opts(noremap, silent) },
  -- -- nvimtree
  -- { '<Leader>e', cmd('NvimTreeToggle'), opts(noremap, silent) },
  -- -- Telescope
  -- { '<Leader>b', cmd('Telescope buffers'), opts(noremap, silent) },
  -- { '<Leader>fa', cmd('Telescope live_grep'), opts(noremap, silent) },
  -- { '<Leader>ff', cmd('Telescope find_files'), opts(noremap, silent) },
})

--   -- usage example
--   -- nmap({
--   -- 	-- noremal remap
--   -- 	-- close buffer
--   -- 	{ "<M-c>", cmd("bdelete"), opts(noremap, silent, "Close buffer") },
--   -- 	-- save
--   -- 	{ "<leader>w", cmd("write"), opts(noremap, "Save Buffer") },
--   -- 	-- quit
--   -- 	{ "<leader>q", cmd("quit"), opts(noremap, "Quit of buffer") },
--   -- 	-- yank
--   -- 	{ "<leader>yy", '"+yy', opts(noremap, "Yank on clipboard") },
--   -- 	{ "Y", "y$", opts(noremap) },
--   -- 	{ "<leader>Y", '"+y$', opts(noremap, "Yanc to end to clipboard") },
--   -- 	-- buffer jump
--   -- 	{ "]b", cmd("bn"), opts(noremap) },
--   -- 	{ "[b", cmd("bp"), opts(noremap) },
--   -- 	-- remove trailing white space
--   -- 	{ "<Leader>t", cmd("TrimTrailingWhitespace"), opts(noremap) },
--   -- 	-- window jump
--   -- 	{ "<C-h>", "<C-w>h", opts(noremap) },
--   -- 	{ "<C-l>", "<C-w>l", opts(noremap) },
--   -- 	{ "<C-j>", "<C-w>j", opts(noremap) },
--   -- 	{ "<C-k>", "<C-w>k", opts(noremap) },
--   -- })
--
--   imap({
--     -- insert mode
--     { '<C-h>', '<Bs>', opts(noremap) },
--     { '<C-e>', '<End>', opts(noremap) },
--   })
--
--   -- commandline remap
--   cmap({ '<C-b>', '<Left>', opts(noremap) })
--
--   -- usage of plugins
--   nmap({
--     -- plugin manager: Lazy.nvim
--     { '<Leader>pu', cmd('Lazy update'), opts(noremap, silent) },
--     { '<Leader>pi', cmd('Lazy install'), opts(noremap, silent) },
--     -- dashboard
--     { '<Leader>n', cmd('DashboardNewFile'), opts(noremap, silent) },
--     { '<Leader>ss', cmd('SessionSave'), opts(noremap, silent) },
--     { '<Leader>sl', cmd('SessionLoad'), opts(noremap, silent) },
--     -- nvimtree
--     { '<Leader>e', cmd('NvimTreeToggle'), opts(noremap, silent) },
--     -- Telescope
--     { '<Leader>b', cmd('Telescope buffers'), opts(noremap, silent) },
--     { '<Leader>fa', cmd('Telescope live_grep'), opts(noremap, silent) },
--     { '<Leader>ff', cmd('Telescope find_files'), opts(noremap, silent) },
--   })
--
--   ------------------------
--
--   -- Regular maps
--   map({ 'x', 'i', 'n' }, '<C-c>', '<ESC>', { silent = true, desc = 'Stop on esc' })
--
--   --  Single xmaps
--   xmap({
--     { '<leader>p', '"_dP', opts(silent, 'Paste without lose the content') },
--     { '<leader>y', '"+y', opts(silent, 'Copy selection in clipboard') },
--   })
--
--   -- Single nomral maps
--   nmap({
--     -- Home key with 0
--     { '0', homeVsKey, opts(silent, expr, 'Home key like vscode') },
--     -- noremal remap
--     -- close buffer
--     { '<M-c>', brem, opts(noremap, silent, 'Close buffer') },
--     -- save
--     { '<leader>w', cmd('write'), opts(noremap, 'Save Buffer') },
--     -- quit
--     { '<leader>q', cmd('quit'), opts(noremap, 'Quit of buffer') },
--     -- yank
--     { '<leader>yy', '"+yy', opts(noremap, 'Yank on clipboard') },
--     { 'Y', 'y$', opts(noremap) },
--     { '<leader>Y', '"+y$', opts(noremap, 'Yanc to end to clipboard') },
--     -- buffer jump
--     { ']b', cmd('bn'), opts(noremap) },
--     { '[b', cmd('bp'), opts(noremap) },
--   })
