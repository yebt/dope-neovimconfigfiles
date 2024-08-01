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

  --- Which Key
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      ---@type false | "classic" | "modern" | "helix"
      preset = 'helix',
      icons = {
        breadcrumb = '»', -- symbol used in the command line area that shows your active key combo
        -- ⤳ ⤑ 🠶 ⤇ ➔ ↯ ↬ ⇛ ➝
        separator = '·> ', -- symbol used between a key and it's label
        group = '+', -- symbol prepended to a group
        ellipsis = '…',
        -- set to false to disable all mapping icons,
        -- both those explicitely added in a mapping
        -- and those from rules
        mappings = false,
        --- See `lua/which-key/icons.lua` for more details
        --- Set to `false` to disable keymap icons from rules
        ---@type wk.IconRule[]|false
        rules = {},
        -- use the highlights from mini.icons
        -- When `false`, it will use `WhichKeyIcon` instead
        colors = true,
      },
    },
    keys = {
      {
        '<leader>?',
        function()
          require('which-key').show({ global = false })
        end,
        desc = 'Buffer Local Keymaps (which-key)',
      },
    },
  },

  --- Remove buffer
  {
    'echasnovski/mini.bufremove',
    version = false,
    keys = {
      {
        '<M-c>',
        function()
          MiniBufremove.delete()
        end,
      },
    },
    opts = {
      -- Whether to set Vim's settings for buffers (allow hidden buffers)
      set_vim_settings = true,

      -- Whether to disable showing non-error feedback
      silent = false,
    },
  },
}
