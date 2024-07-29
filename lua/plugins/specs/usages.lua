-- Plugins to make a better usage
return {

  --- Align
  {
    'echasnovski/mini.align',
    version = false,
    keys = {
      { 'ga', mode = { 'n', 'x' } },
      { 'gA', mode = { 'n', 'x' } },
    },
    config = require('plugins.configs.minialignc'),
  },
}
