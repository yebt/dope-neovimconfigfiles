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
      'zipPlugin',
    },
  },

  plugins = {
    completion = nil,
  },
}

kernel.setup = function(opts)
  kernel.opts = vim.tbl_deep_extend('force', default_opts, opts)

  -- call leader
  --- Maps
  vim.g.mapleader = kernel.opts.leader or ' '
  vim.g.maplocalleader = kernel.opts.localleader or ' '

  -- Load the initial files
  local initials = {
    'options',
    'autocmds',
    'keymaps',
    'lsp',
  }
  for _, file in ipairs(initials) do
    require('kernel.' .. file)
  end

  vim.api.nvim_create_autocmd({ 'User' }, {
    pattern = { 'PostPlugins' },
    callback = function(args)
      -- aditional filetype event on verylazy

      vim.api.nvim_exec_autocmds('FileType', {})

      local lazy_loads = {
        -- 'keys',
        -- 'events',
        -- 'status',
        -- 'lsp',
      }
      if kernel.opts.plugins.satatusline == 'builtin' then
        table.insert(lazy_loads, 'status')
      end

      for _, file in pairs(lazy_loads) do
        require('internal.' .. file)
      end
    end,
  })

  -- call bootstrap
  require('bootstrap.lazyinit')
  -- colorscheme
  local ok, _ = pcall(vim.cmd.colorscheme, kernel.opts.colorscheme)
  if not ok then
    vim.notify("Error when try to load colorscheme '" .. kernel.opts.colorscheme .. "'")
    vim.cmd.colorscheme('desert')
  end
end

-- return
_G.kernel = kernel
return kernel
