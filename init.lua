require('kernel').setup({
  -- colorscheme = 'habamax',
  -- colorscheme = 'tokyonight-night',
  colorscheme = 'tokyonight',

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

    completion = 'epo',
    -- completion = 'cmp',
    -- completion = 'minicompletion',

    -- notification = "notifier",
    -- notification = 'mininotify',
  },
})
