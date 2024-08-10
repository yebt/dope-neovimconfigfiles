--- ----------------------------------------
--- Editor view
--- ----------------------------------------

return {

  --- Indentation
  {
    'nvimdev/indentmini.nvim',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre', 'VeryLazy' },
    opts = {
      -- char = "│",
      -- ╎ │ ▏
      char = '▏',
      exclude = { 'markdown' },
      minlevel = 1,
    },
  },

  --- Carbon File explorer
  {
    'SidOfc/carbon.nvim',
    cmd = {
      'Carbon',
      'Explore',
      'Lcarbon',
      'Lexplore',
      'Fcarbon',
      'Rexplore',
      'Fcarbon',
      'ToggleSidebarCarbon',
    },
    keys = {
      { '\\', ':ToggleSidebarCarbon<CR>', silent = true },
      { '¿', ':ToggleSidebarCarbon!<CR>', silent = true },
    },
    opts = {
      compress = true, --- compress empty dirs
      auto_open = false, --- open neovim with dir
      keep_netrw = true, --- allow netrw
      -- auto_reveal = true, --- reveal file by default
      open_on_dir = true,
      indicators = {
        expand = '+',
        collapse = '-',
      },
      flash = {
        delay = 100,
        duration = 600,
      },
    },
    -- lazy = false,
    init = function()
      ---- Load on init if is needed
      local stats = vim.uv.fs_stat(vim.fn.argv(0))
      if stats and stats.type == 'directory' then
        require('carbon')
      end

      --       if stats and stats.type == 'directory' then
      -- require("carbon")
      -- local group = vim.api.nvim_create_augroup('carbon_manage', { clear = true })
      --- Try to start the directory
      -- vim.api.nvim_create_autocmd('BufEnter', {
      --   group = vim.api.nvim_create_augroup('Carbon_start_dir', { clear = true }),
      --   desc = 'Start Carbon with directory',
      --   once = true,
      --   callback = function()
      --     if package.loaded['carbon'] then
      --       return
      --     else
      --       local stats = vim.uv.fs_stat(vim.fn.argv(0))
      --       if stats and stats.type == 'directory' then
      --         vim.schedule(function()
      --           --
      --           vim.api.nvim_create_autocmd('User', {
      --             pattern = 'VeryLazy',
      --             desc = 'Start Carbon with directory',
      --             once = true,
      --             callback = function()
      --               require('carbon')
      --               -- require('carbon').setup({})
      --               -- require('carbon').explore()
      --               -- require('carbon').explore_left()
      --               -- vim.cmd("Carbon " .. vim.fn.argv(0))
      --             end,
      --           })
      --           -- vim.cmd("Carbon .")
      --           -- require('carbon')
      --           -- require('carbon').explore()
      --           -- require('carbon').explore_left()
      --         end)
      --       end
      --     end
      --   end,
      -- })
      -- vim.api.nvim_create_autocmd('Filetype', {
      --   group = group,
      --   pattern = 'carbon.explorer',
      --   callback = function(args)
      --     local bfn = args.buf
      --     local cwnd = vim.api.nvim_get_current_win()
      --     vim.schedule(function()
      --       vim.wo[cwnd].nu = false
      --       vim.wo[cwnd].rnu = false
      --       vim.wo[cwnd].cul = false
      --       vim.wo[cwnd].scl = 'no'
      --       vim.wo[cwnd].fdc = '0'
      --       -- vim.wo.nu = false
      --       -- vim.wo.rnu = false
      --       -- vim.wo.cul = true
      --     end)
      --   end,
      -- })
    end,
  },

  --- TODO comments
  {
    'folke/todo-comments.nvim',
    cmd = { 'TodoTrouble', 'TodoTelescope' },
    event = { 'LazyFile', 'VeryLazy' },
    opts = {
      signs = true, -- show icons in the signs column
      sign_priority = 8, -- sign priority
      -- keywords recognized as todo comments
      keywords = {
        FIX = {
          icon = ' ', -- icon used for the sign, and in search results
          color = 'error', -- can be a hex color, or a named color (see below)
          alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' }, -- a set of other keywords that all map to this FIX keywords
          -- signs = false, -- configure signs for some keywords individually
        },
        TODO = { icon = ' ', color = 'info' },
        HACK = { icon = ' ', color = 'warning' },
        WARN = { icon = '󰀪 ', color = 'warning', alt = { 'WARNING', 'XXX' } },
        PERF = { icon = ' ', alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } },
        NOTE = { icon = ' ', color = 'hint', alt = { 'INFO' } },
        TEST = { icon = '󰙨 ', color = 'test', alt = { 'TESTING', 'PASSED', 'FAILED' } },
      },
      gui_style = {
        fg = 'NONE', -- The gui style to use for the fg highlight group.
        bg = 'BOLD', -- The gui style to use for the bg highlight group.
      },
      merge_keywords = true, -- when true, custom keywords will be merged with the defaults
      -- highlighting of the line containing the todo comment
      -- * before: highlights before the keyword (typically comment characters)
      -- * keyword: highlights of the keyword
      -- * after: highlights after the keyword (todo text)
      highlight = {
        multiline = false, -- enable multine todo comments
        multiline_pattern = '^.', -- lua pattern to match the next multiline from the start of the matched keyword
        multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
        before = '', -- "fg" or "bg" or empty
        keyword = 'wide', -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
        after = 'fg', -- "fg" or "bg" or empty
        pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
        comments_only = true, -- uses treesitter to match keywords in comments only
        max_line_len = 400, -- ignore lines longer than this
        exclude = {}, -- list of file types to exclude highlighting
      },
      -- list of named colors where we try to extract the guifg from the
      -- list of highlight groups or use the hex color if hl not found as a fallback
      colors = {
        error = { 'DiagnosticError', 'ErrorMsg', '#DC2626' },
        warning = { 'DiagnosticWarn', 'WarningMsg', '#FBBF24' },
        info = { 'DiagnosticInfo', '#2563EB' },
        hint = { 'DiagnosticHint', '#10B981' },
        default = { 'Identifier', '#7C3AED' },
        test = { 'Identifier', '#FF00FF' },
      },
      search = {
        command = 'rg',
        args = {
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
        },
        -- regex that will be used to match keywords.
        -- don't replace the (KEYWORDS) placeholder
        pattern = [[\b(KEYWORDS):]], -- ripgrep regex
        -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
      },
    },
    -- stylua: ignore
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
      { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
    },
  },

  --- Iterator
  {
    'folke/trouble.nvim',
    cmd = { 'Trouble' },
    opts = {},
  },

  --- Sessions
  {
    'echasnovski/mini.sessions',
    version = false,
    config = require('plugins.configs.minisessionsc'),
  },
}
