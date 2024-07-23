return {
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
