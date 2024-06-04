----------------------------------
--- This file contain the events
--- to call
----------------------------------

local api = vim.api
local au = api.nvim_create_autocmd
local group = vim.api.nvim_create_augroup('_group', {})

-- Load post files
au('BufEnter', {
  group = group,
  once = true,
  callback = function()
    require('keymap')
  end,
})

-- Load plugins on insert
au('InsertEnter', {
  group = group,
  callback = function()
    require('internal.pairs').setup({})
  end,
})

-- Ignore undo files
au('BufWritePre', {
  group = group,
  pattern = { '/tmp/*', 'COMMIT_EDITMSG', 'MERGE_MSG', '*.tmp', '*.bak' },
  command = 'setlocal noundofile',
})

-- High Light yank
au('TextYankPost', {
  group = group,
  callback = function()
    --vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 400 })
    vim.highlight.on_yank()
  end,
})

--disable diagnostic in neovim test file *_spec.lua
-- au('FileType', {
--   group = group,
--   pattern = 'lua',
--   callback = function(opt)
--     local fname = vim.api.nvim_buf_get_name(opt.buf)
--     if fname:find('%w_spec%.lua') then
--       vim.diagnostic.enable(not vim.diagnostic.is_enabled({ bufnr = opt.buf }))
--     end
--   end,
-- })

-- Terminal
au('TermOpen', {
  group = group,
  callback = function()
    vim.opt_local.stc = ''
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = 'no'
    vim.cmd.startinsert()
  end,
})
au({ 'BufLeave' }, { pattern = { 'term://*' }, group = group, command = [[stopinsert]] })

-- go to last loc when opening a buffer
au('BufReadPost', {
  group = group,
  callback = function(event)
    local exclude = { 'gitcommit' }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
      return
    end
    vim.b[buf].lazyvim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- close some filetypes with <q>
au('FileType', {
  group = group,
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
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
  end,
})

-- make it easier to close man-files when opened inline
au('FileType', {
  group = group,
  pattern = { 'man' },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
  end,
})

-- wrap and check for spell in text filetypes
au('FileType', {
  group = roup,
  pattern = { 'gitcommit', 'markdown' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Fix conceallevel for json files
au({ 'FileType' }, {
  group = group,
  pattern = { 'json', 'jsonc', 'json5' },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
-- au({ "BufWritePre" }, {
--   group = group,
--   callback = function(event)
--     if event.match:match("^%w%w+:[\\/][\\/]") then
--       return
--     end
--     local file = vim.uv.fs_realpath(event.match) or event.match
--     vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
--   end,
-- })

au({ 'User' }, {
  pattern = { 'VeryLazy' },
  group = group,
  callback = function()
    -- require('internal.cmds')
  end,
})

vim.on_key(function(char)
  if vim.fn.mode() == 'n' then
    local new_hlsearch = vim.tbl_contains({ '<CR>', 'n', 'N', '*', '#', '?', '/' }, vim.fn.keytrans(char))
    if vim.opt.hlsearch:get() ~= new_hlsearch then
      vim.opt.hlsearch = new_hlsearch
    end
  end
end, vim.api.nvim_create_namespace('auto_hlsearch'))
