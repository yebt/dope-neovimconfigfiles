require('kernel').setup({
  -- colorscheme = 'habamax',
  -- colorscheme = 'tokyonight-night',
  -- colorscheme = 'tokyonight',
  -- colorscheme = 'porcelain',
  colorscheme = 'kanagawa',
  -- colorscheme = 'catppuccin',

  keys = {
    leader = ' ',
    localleader = ',',
  },
  yanc_timeout = 150,
  plugins = {

    -- finder = "fzf-lua",
    -- finder = "telescope",
    -- telescope="fzf-native" -- used if finder is telescope
    finder = 'mini.pick',
    pickicons = 'dev', -- 'mini', 'dev'

    satatusline = 'builtin',

    foldcolumn = 'sign', -- 'builtina', 'sign'

    completion = 'epo',
    -- completion = 'cmp',
    -- completion = 'minicompletion',

    -- notification = "notifier",
    -- notification = 'mininotify',

    sessions = 'minisessions', -- minisessions, persistence
    sessions_dir =  vim.fn.stdpath('state') .. '/sessions/',
  },
})
