local agroup = vim.api.nvim_create_augroup
local au = vim.api.nvim_create_autocmd
local cmd = vim.cmd

local function ag(name)
  return agroup('core_' .. name, { clear = true })
end

-- auto no h in normal mode
vim.on_key(function(char)
  if vim.fn.mode() == 'n' then
    local new_hlsearch = vim.tbl_contains({ '<CR>', 'n', 'N', '*', '#', '?', '/' }, vim.fn.keytrans(char))
    if vim.opt.hlsearch:get() ~= new_hlsearch then
      vim.opt.hlsearch = new_hlsearch
    end
  end
end, vim.api.nvim_create_namespace('auto_hlsearch'))

--
-- Check if we need to reload the file when it changed
au({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  group = ag('checktime'),
  callback = function()
    if vim.o.buftype ~= 'nofile' then
      vim.cmd('checktime')
    end
  end,
})

--
-- Highlight on yank
au('TextYankPost', {
  group = ag('highlight_yank'),
  callback = function()
    vim.highlight.on_yank()
  end,
})

--
-- resize splits if window got resized
au({ 'VimResized' }, {
  group = ag('resize_splits'),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd('tabdo wincmd =')
    vim.cmd('tabnext ' .. current_tab)
  end,
})

--
-- Restore positions
-- au("BufReadPost", {
--   group = ag("last_loc"),
--   callback = function(event)
--     local exclude = { "gitcommit" }
--     local buf = event.buf
--     if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
--       return
--     end
--     vim.b[buf].lazyvim_last_loc = true
--     local mark = vim.api.nvim_buf_get_mark(buf, '"')
--     local lcount = vim.api.nvim_buf_line_count(buf)
--     if mark[1] > 0 and mark[1] <= lcount then
--       pcall(vim.api.nvim_win_set_cursor, 0, mark)
--     end
--   end,
-- })

-- Automake the views

local view_group = ag('_auto_view')
-- Make view
au({ 'BufWinLeave', 'BufWritePost', 'WinLeave' }, {
  desc = 'Save view with mkview for real files',
  group = view_group,
  callback = function(event)
    if vim.b[event.buf].view_activated then
      vim.cmd.mkview({ mods = { emsg_silent = true } })
    end
  end,
})

-- Load view
au('BufWinEnter', {
  desc = 'Try to load file view if available and enable view saving for real files',
  group = view_group,
  callback = function(event)
    if not vim.b[event.buf].view_activated then
      local filetype = vim.api.nvim_get_option_value('filetype', { buf = event.buf })
      local buftype = vim.api.nvim_get_option_value('buftype', { buf = event.buf })
      local ignore_filetypes = { 'gitcommit', 'gitrebase', 'svg', 'hgcommit' }
      if buftype == '' and filetype and filetype ~= '' and not vim.tbl_contains(ignore_filetypes, filetype) then
        vim.b[event.buf].view_activated = true
        vim.cmd.loadview({ mods = { emsg_silent = true } })
      end
    end
  end,
})

--
-- Add fast close (q) to some files
au('FileType', {
  group = ag('close_with_q'),
  pattern = {
    'PlenaryTestPopup',
    'help',
    'lspinfo',
    'notify',
    'qf',
    'spectre_panel',
    'startuptime',
    'tsplayground',
    'neotest-output',
    'checkhealth',
    'neotest-summary',
    'neotest-output-panel',
    'dbout',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
  end,
})

--
-- Enable spell for typing files
-- wrap and check for spell in text filetypes
au('FileType', {
  group = ag('wrap_spell'),
  pattern = { '*.txt', '*.tex', '*.typ', 'gitcommit', 'markdown' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

--
-- Better conceal level for json files
au({ 'FileType' }, {
  group = ag('json_conceal'),
  pattern = { 'json', 'jsonc', 'json5' },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

--
-- Terminal view
local c = ag('terming')
au({ 'TermOpen' }, {
  group = c,
  callback = function()
    vim.opt_local.conceallevel = 0
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = 'no'
    vim.cmd('startinsert')
  end,
})
au({ 'BufEnter', 'WinEnter' }, { pattern = { 'term://*' }, group = c, command = [[startinsert]] })
au({ 'BufLeave' }, { pattern = { 'term://*' }, group = c, command = [[stopinsert]] })
