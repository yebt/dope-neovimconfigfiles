return function()
  local au = vim.api.nvim_create_autocmd
  local function augroup(name)
    return vim.api.nvim_create_augroup('_kernel_' .. name, { clear = true })
  end

  vim.ui.select = function(...)
    vim.ui.select = require("mini.pick").ui_select
    return vim.ui.select(...)
  end

  -- vim.keymap.set('n', '<C-b>', function()
  --   local bfs = _G._kernel._bufferslist
  --   vim.notify(vim.inspect(bfs or 'No BL'))
  -- end, { desc = 'Print the list of buffers' })

  -- Init the list
  if not _G._kernel._bufferslist then
    _G._kernel._bufferslist = {}
  end

  local gbl = augroup('buffersl')
  au({ 'BufWinEnter', 'WinEnter' }, {
    group = gbl,
    callback = function(args)
      _G._kernel._bufferslist[args.buf] = vim.fn.reltimefloat(vim.fn.reltime())
    end,
  })

  au({ 'BufDelete' }, {
    group = gbl,
    callback = function(args)
      _G._kernel._bufferslist[args.buf] = null
    end,
  })
end
