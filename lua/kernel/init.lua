local defaults = require('kernel.defaults')
local kernel = {}

-- Control
local function load_conf(name)
  require('config' .. '.' .. name)
end

-- SETUP
function setup(opts)
  local options = vim.tbl_deep_extend('force', defaults, opts or {}) or {}

  -- Make the kernel global
  kernel.options = options
  _G._kernel = kernel

  -- make leaders pre lazy.nvim
  vim.g.mapleader = options.keys.leader or ' '
  vim.g.maplocalleader = options.keys.localleader or ' '

  -- Bootstrap lazy
  load_conf('options')
  load_conf('lazy')
  --
  -- call colorscheme
  local ok, _ = pcall(vim.cmd.colorscheme, options.colorscheme)
  if not ok then
    -- vim.notify("Error when try to load colorscheme '" .. options.colorscheme .. "'")
    vim.cmd.colorscheme('habamax')
  end

  -- autocmds can be loaded lazily when not opening a file
  local without_args = vim.fn.argc(-1) == 0
  if not without_args then
    load_conf('autocmds')
  end

  local group = vim.api.nvim_create_augroup('LazyVim', { clear = true })

  vim.api.nvim_create_autocmd('User', {
    group = group,
    pattern = 'VeryLazy',
    callback = function()
      if without_args then
        load_conf('autocmds')
      end
      load_conf('keymaps')
      -- require('inside.statusline').setup()
      -- vim.api.nvim_exec_autocmds('FileType', {})
    end,
  })
end

return {
  setup = setup,
}
