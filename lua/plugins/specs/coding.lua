--- ----------------------------------------
--- Coding better
--- ----------------------------------------
return {

  --- Auto Close tags
  {
    'windwp/nvim-ts-autotag',
    event = 'LazyFile',
    config = require('plugins.configs.tsatuotagc'),
  },

  --- :e
}
