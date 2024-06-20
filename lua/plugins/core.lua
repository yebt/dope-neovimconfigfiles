return {
  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    -- event={"VeryLazy"},
    build = ':TSUpdate',
    config = function()
      local configs = require('nvim-treesitter.configs')

      configs.setup({
        ensure_installed = {
          'c',
          'lua',
          'vim',
          'vimdoc',
          'query',
          'elixir',
          'heex',
          'javascript',
          'html',
        },
        sync_install = false,
        highlight = {
          enable = true,
          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = 'gnn', -- set to `false` to disable one of the mappings
            node_incremental = 'grn',
            scope_incremental = 'grc',
            node_decremental = 'grm',
          },
        },
        indent = {
          enable = true,
        },
        -- rainbow = {
        --   enable = true,
        --   -- list of languages you want to disable the plugin for
        --   disable = { 'jsx', 'cpp' },
        --   -- Which query to use for finding delimiters
        --   query = 'rainbow-parens',
        --   -- Highlight the entire buffer all at once
        --   strategy = require('ts-rainbow').strategy.global,
        -- },
      })
    end,
  },

  -- Better comment string
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    event = {
      'VeryLazy',
    },
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
  },

  -- Better practices
  {
    'm4xshen/hardtime.nvim',
    lazy = false,
    dependencies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
    opts = {
      disable_mouse = _G.globals.disable_mouse or false,
      -- Add "oil" to the disabled_filetypes
      disabled_filetypes = {
        'qf',
        'netrw',
        'NvimTree',
        'lazy',
        'mason',
        'oil',
        'netrw',
        'NvimTree',
        'TelescopePrompt',
        'aerial',
        'alpha',
        'checkhealth',
        'dapui*',
        'Diffview*',
        'Dressing*',
        'help',
        'httpResult',
        'lazy',
        'lspinfo',
        'Neogit*',
        'mason',
        'neotest%-summary',
        'minifiles',
        'neo%-tree*',
        'netrw',
        'noice',
        'notify',
        'prompt',
        'qf',
        'query',
        'oil',
        'undotree',
        'trouble',
        'Trouble',
        'fugitive',
      },
    },
  },

  -- Jump and motions
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@type Flash.Config
    opts = {
      modes = {
        char = {
          jump_labels = true,
        },
      },
    },
    keys = {
      -- jump in search
      {
        's',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').jump()
        end,
        desc = 'Flash',
      },
      -- jump with treesitter
      {
        'S',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').treesitter()
        end,
        desc = 'Flash Treesitter',
      },
      -- Remote
      {
        'r',
        mode = 'o',
        function()
          require('flash').remote()
        end,
        desc = 'Remote Flash',
      },
      {
        'R',
        mode = { 'o', 'x' },
        function()
          require('flash').treesitter_search()
        end,
        desc = 'Treesitter Search',
      },
      {
        '<c-s>',
        mode = { 'c' },
        function()
          require('flash').toggle()
        end,
        desc = 'Toggle Flash Search',
      },
      "f","F","t","T",";",","
    },
  },
}
