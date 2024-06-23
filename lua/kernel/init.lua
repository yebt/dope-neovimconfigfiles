-- Kernel
local kernel = {}

-- default copnfigs
local default_opts = {
  colorscheme = 'dessert',
  text_filetypes = { '*.txt', '*.tex', '*.typ', 'gitcommit', 'markdown' },

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
    },
  },
}

kernel.setup = function(opts)
  kernel.opts = vim.tbl_deep_extend('force', default_opts, opts)
  -- call bootstrap
  local ok, r = pcall(vim.cmd.colorscheme, kernel.opts.colorscheme)
  if not ok then
    vim.notify("Error when try to load colorscheme '" .. kernel.opts.colorscheme .. "'")
    vim.cmd.colorscheme('desert')
  end

  -- call leader
  --- Maps
  vim.g.mapleader = kernel.opts.leader or ' '
  vim.g.maplocalleader = kernel.opts.localleader or ' '

  -- Load the initial files
  local initials = {
    'options',
    'autocmds',
    'keymaps',
  }
  for _, file in ipairs(initials) do
    require('kernel.' .. file)
  end
end

-- return
_G.kernel = kernel
return kernel
