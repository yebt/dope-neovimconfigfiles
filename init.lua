require('kernel').setup({
  -- colorscheme = 'habamax',
  -- colorscheme = 'tokyonight-night',
  colorscheme = 'tokyonight',

  keys = {
    leader = ' ',
    localleader = ',',
  },

  plugins = {
    satatusline = 'builtin',
    completion = 'epo',
    -- completion = 'cmp',
    -- completion = 'minicompletion',

    -- notification = "notifier",
    -- notification = 'mininotify',
  },
})
