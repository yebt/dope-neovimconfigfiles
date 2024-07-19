--

local defaults = {
  colorscheme = 'dessert',
  text_filetypes = { '*.txt', '*.tex', '*.typ', 'gitcommit', 'markdown' },
  keys = {
    -- leader = ' ',
    -- localleader = ',',
  },
  lazy = {
    desiabled_plugins = {
      -- "editorconfig",
      'zip',
      'gzip',
      'man',
      -- "matchit",
      -- "matchparen",
      -- "netrwPlugin",
      'nvim',
      'osc52',
      'rplugin',
      'shada',
      -- "spellfile",
      'tarPlugin',
      'tohtml',
      'tohtml',
      'tutor',
      'zipPlugin',
    },
  },
  plugins = {
    completion = nil,
  },
}

local options
local function load_conf(name)
  require('config' .. '.' .. name)
end

function setup(opts)
  options = vim.tbl_deep_extend('force', defaults, opts or {}) or {}

  -- make leaders pre lazy.nvim
  vim.g.mapleader = options.keys.leader or ' '
  vim.g.maplocalleader = options.keys.localleader or ' '

  -- Bootstrap lazy
  load_conf('lazy')
  load_conf('options')

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
      -- call colorscheme
      local ok, _ = pcall(vim.cmd.colorscheme, options.colorscheme)
      if not ok then
        vim.notify("Error when try to load colorscheme '" .. options.colorscheme .. "'")
        vim.cmd.colorscheme('habamax')
      end
    end,
  })
end

local M = {
  setup = setup,
  options = options
}
_G._kernel = M
return M
