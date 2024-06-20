return {
  -- buferlist jump helper
  {
    'ghillb/cybu.nvim',
    branch = 'main', -- timely updates
    -- branch = "v1.x", -- won't receive breaking changes
    dependencies = { 'nvim-tree/nvim-web-devicons', 'nvim-lua/plenary.nvim' }, -- optional for icon support
    keys = {
      { '<M-a>', '<Plug>(CybuPrev)' },
      { '<M-d>', '<Plug>(CybuNext)' },
    },
    opts = {
      position = {
        relative_to = 'win', -- win, editor, cursor
        anchor = 'topcenter', -- topleft, topcenter, topright,
        -- centerleft, center, centerright,
        -- bottomleft, bottomcenter, bottomright
        vertical_offset = 10, -- vertical offset from anchor in lines
        horizontal_offset = 0, -- vertical offset from anchor in columns
        max_win_height = 6, -- height of cybu window in lines
        max_win_width = 0.5, -- integer for absolute in columns
        -- float for relative to win/editor width
      },
      style = {
        path = 'relative', -- absolute, relative, tail (filename only)
        path_abbreviation = 'none', -- none, shortened
        border = 'rounded', -- single, double, rounded, none
        separator = ' ', -- string used as separator
        prefix = '…', -- string used as prefix for truncated paths
        padding = 1, -- left & right padding in number of spaces
        hide_buffer_id = true, -- hide buffer IDs in window
        devicons = {
          enabled = true, -- enable or disable web dev icons
          colored = true, -- enable color for web dev icons
          truncate = true, -- truncate wide icons to one char width
        },
        highlights = { -- see highlights via :highlight
          current_buffer = 'CybuFocus', -- current / selected buffer
          adjacent_buffers = 'CybuAdjacent', -- buffers not in focus
          background = 'CybuBackground', -- window background
          border = 'CybuBorder', -- border of the window
        },
      },
      behavior = { -- set behavior for different modes
        mode = {
          default = {
            switch = 'immediate', -- immediate, on_close
            view = 'rolling', -- paging, rolling
          },
          last_used = {
            switch = 'on_close', -- immediate, on_close
            view = 'paging', -- paging, rolling
          },
          auto = {
            view = 'rolling', -- paging, rolling
          },
        },
        show_on_autocmd = false, -- event to trigger cybu (eg. "BufEnter")
      },
      display_time = 750, -- time the cybu window is displayed
      exclude = { -- filetypes, cybu will not be active
        'neo-tree',
        'fugitive',
        'qf',
      },
      filter = {
        unlisted = true, -- filter & fallback for unlisted buffers
      },
      fallback = function() end, -- arbitrary fallback function
      -- used in excluded filetypes
    },
    -- config = function()
    --   local ok, cybu = pcall(require, 'cybu')
    --   if not ok then
    --     return
    --   end
    --   cybu.setup()
    --   vim.keymap.set('n', 'K', '<Plug>(CybuPrev)')
    --   vim.keymap.set('n', 'J', '<Plug>(CybuNext)')
    --   vim.keymap.set({ 'n', 'v' }, '<c-s-tab>', '<plug>(CybuLastusedPrev)')
    --   vim.keymap.set({ 'n', 'v' }, '<c-tab>', '<plug>(CybuLastusedNext)')
    -- end,
  },

  -- Notifier
  -- {
  --   'vigoux/notifier.nvim',
  --   lazy = false,
  --   priority=100,
  --   opts = {
  --     ignore_messages = {}, -- Ignore message from LSP servers with this name
  --     status_width = something, -- COmputed using 'columns' and 'textwidth'
  --     components = { -- Order of the components to draw from top to bottom (first nvim notifications, then lsp)
  --       'nvim', -- Nvim notifications (vim.notify and such)
  --       'lsp', -- LSP status updates
  --     },
  --     notify = {
  --       clear_time = 5000, -- Time in milliseconds before removing a vim.notify notification, 0 to make them sticky
  --       min_level = vim.log.levels.TRACE, -- Minimum log level to print the notification
  --     },
  --     component_name_recall = false, -- Whether to prefix the title of the notification by the component name
  --     zindex = 50, -- The zindex to use for the floating window. Note that changing this value may cause visual bugs with other windows overlapping the notifier window.
  --   },
  -- },
  -- {
  --   'echasnovski/mini.nvim',
  --   version = '*',
  --   lazy = false,
  --   -- No need to copy this inside `setup()`. Will be used automatically.
  --   opts = {
  --     -- Content management
  --     content = {
  --       -- Function which formats the notification message
  --       -- By default prepends message with notification time
  --       -- format = nil,
  --       -- format = function(notif)
  --       --
  --       --   return vim.inspect(notif)
  --       -- end,
  --
  --       -- Function which orders notification array from most to least important
  --       -- By default orders first by level and then by update timestamp
  --       sort = nil,
  --     },
  --
  --     -- Notifications about LSP progress
  --     lsp_progress = {
  --       -- Whether to enable showing
  --       enable = true,
  --
  --       -- Duration (in ms) of how long last message should be shown
  --       duration_last = 1000,
  --     },
  --
  --     -- Window options
  --     window = {
  --       -- Floating window config
  --       config = {},
  --
  --       -- Maximum window width as share (between 0 and 1) of available columns
  --       max_width_share = 0.382,
  --
  --       -- Value of 'winblend' option
  --       winblend = 25,
  --     },
  --   },
  --   config = function(_, opts)
  --     local notify = require('mini.notify')
  --     notify.setup(opts)
  --     vim.notify = notify.make_notify(
  --       --
  --       {
  --         -- ERROR = { duration = 5000, hl_group = 'DiagnosticError' },
  --         -- WARN = { duration = 5000, hl_group = 'DiagnosticWarn' },
  --         -- INFO = { duration = 5000, hl_group = 'DiagnosticInfo' },
  --         -- DEBUG = { duration = 0, hl_group = 'DiagnosticHint' },
  --         -- TRACE = { duration = 0, hl_group = 'DiagnosticOk' },
  --         -- OFF = { duration = 0, hl_group = 'MiniNotifyNormal' },
  --       }
  --     )
  --   end,
  -- },

  {
    'rcarriga/nvim-notify',
    lazy = false,
    opts = {
      timeout = '2000',
      -- render="wrapped-compact",
      render = 'minimal',
      stages = 'static',
    },
    config = function(_, opts)
      vim.notify = require('notify')
      vim.notify.setup(opts)
    end,
  },

  --- Starter view
  {
    'echasnovski/mini.starter',
    version = false,
    event = 'VimEnter',
    cond = function()
      local lines = vim.api.nvim_buf_get_lines(0, 0, 2, false)
      local skip = vim.fn.argc() > 0 -- don't start with a init with a file
        or #lines > 1 -- don't open if curent buffer has more then 1 line
        or (#lines == 1 and lines[1]:len() > 0) -- don't open the current buffer if it has anything on the firt lione
        or #vim.tbl_filter(function(bufnr)
            return vim.bo[bufnr].buflisted
          end, vim.api.nvim_list_bufs())
          > 1 -- don't open if any listed buffers
        or not vim.o.modifiable -- don't open if not modifiable

      if not skip then
        for _, arg in pairs(vim.v.argv) do
          if arg == '-b' or arg == '-c' or vim.startswith(arg, '+') or arg == '-S' then
            skip = true
            break
          end
        end
      end
      return not skip
    end,
    config = require('plugins.configs.ministarter'),
  },

  {
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async',
    -- event= {"BufReadPost"},
    event= {"VeryLazy"},
    config = require("plugins.configs.ufo")
  },
}
