local globals = {
  -- Colorscheme
  -- colorscheme = 'habamax',
  -- colorscheme = 'material',
  -- colorscheme = 'solarized-osaka',
  -- colorscheme = 'onedark',
  -- colorscheme = 'monokai-pro',

  -- Text filetypes
  text_filetypes = { '*.txt', '*.tex', '*.typ', 'gitcommit', 'markdown' },
  -- Html filetypes

  colorscheme = 'PaperColor',
  -- Disabled plugins
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
  disable_mouse = true,
}

_G.globals = globals
