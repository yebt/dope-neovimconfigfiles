local package = require('core.pack').package
local conf = require('modules.syntax.config')

package({
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = { 'LazyFile', 'VeryLazy' },
  init = function(plugin)
    -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
    -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
    -- no longer trigger the **nvim-treeitter** module to be loaded in time.
    -- Luckily, the only thins that those plugins need are the custom queries, which we make available
    -- during startup.
    require('lazy.core.loader').add_to_rtp(plugin)
    require('nvim-treesitter.query_predicates')
  end,
  dependencies = {
    {
      'nvim-treesitter/nvim-treesitter-textobjects',
      config = conf.treesitter_textobjects,
    },
  },
  cmd = { 'TSUpdateSync', 'TSUpdate', 'TSInstall' },
  keys = {
    { '<c-space>', desc = 'Increment selection' },
    { '<bs>', desc = 'Decrement selection', mode = 'x' },
  },
  opts = {
    highlight = { enable = true },
    indent = { enable = true },
    ensure_installed = {
      'bash',
      'c',
      'diff',
      'html',
      'javascript',
      'jsdoc',
      'json',
      'jsonc',
      'lua',
      'luadoc',
      'luap',
      'markdown',
      'markdown_inline',
      'python',
      'query',
      'regex',
      'toml',
      'tsx',
      'typescript',
      'vim',
      'vimdoc',
      'yaml',
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<C-space>',
        node_incremental = '<C-space>',
        scope_incremental = false,
        node_decremental = '<bs>',
      },
    },
    textobjects = {
      move = {
        enable = true,
        goto_next_start = { [']f'] = '@function.outer', [']c'] = '@class.outer' },
        goto_next_end = { [']F'] = '@function.outer', [']C'] = '@class.outer' },
        goto_previous_start = { ['[f'] = '@function.outer', ['[c'] = '@class.outer' },
        goto_previous_end = { ['[F'] = '@function.outer', ['[C'] = '@class.outer' },
      },
    },
  },
  config = conf.treesitter,
})

package({
  -- Show context of the current function
  {
    'nvim-treesitter/nvim-treesitter-context',
    event = 'LazyFile',
    opts = {
      enable = false, -- Enable this plugin (Can be enabled/disabled later via commands)
      mode = 'cursor',
      max_lines = 3,
    },
    keys = {
      {
        '<leader>ut',
        ':TSContextToggle<CR>',
        desc = 'Toggle Treesitter Context',
        silent = true,
      },
    },
    cmd = { 'TSContextEnable', 'TSContextDisable', 'TSContextToggle' },
  },
})

package({
  -- Automatically add closing tags for HTML and JSX
  {
    'windwp/nvim-ts-autotag',
    event = { 'LazyFile', 'VeryLazy' },
    opts = {},
  },
})
