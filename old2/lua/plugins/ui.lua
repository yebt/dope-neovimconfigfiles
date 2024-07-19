-- view
return {
  -- Starter view
  {
    "echasnovski/mini.starter",
    version = false,
    event = "VimEnter",
    dependencies = {
      { "echasnovski/mini.sessions", version = false },
    },
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
          if arg == "-b" or arg == "-c" or vim.startswith(arg, "+") or arg == "-S" then
            skip = true
            break
          end
        end
      end
      return not skip
    end,
    config = require("plugins.configs.ministarter"),
  },

  -- Notifications
  {
    "echasnovski/mini.notify",
    version = false,
    event = "VeryLazy",
    cond = _G.kernel.opts.plugins.notification == "mininotify",
    config = require("plugins.configs.mininotify"),
  },
  {
    "vigoux/notifier.nvim",
    lazy = false,
    cond = _G.kernel.opts.plugins.notification == "notifier",
    config = require("plugins.configs.notifier"),
  },

  -- Clue Key Wich
  -- {
  --   'echasnovski/mini.clue',
  --   version = false,
  --   event ="VeryLazy",
  --   config = require('plugins.configs.miniclue')
  -- },

  -- Scope
  {
    "nvimdev/indentmini.nvim",
    event = "VeryLazy",
    config = require("plugins.configs.indentmini"),
  },

  -- indent line
  -- {
  --   "nvimdev/modeline.nvim",
  --   event = "VeryLazy",
  --   -- lazy = false,
  --
  --   config = require("plugins.configs.modeline")
  -- },

  -- Colorized
  {
    "NvChad/nvim-colorizer.lua",
    cmd = { "ColorizerToggle" },
    config = require("plugins.configs.colorizer"),
  },

  -- Reactive
  -- {
  --   'rasulomaroff/reactive.nvim',
  --   event = 'VeryLazy',
  --   opts = {
  --     builtin = {
  --       cursorline = true,
  --       cursor = true,
  --       modemsg = true,
  --     },
  --   },
  -- },

  -- Rainbow pairs
  -- {
  --   'HiPhish/rainbow-delimiters.nvim',
  --   event = 'VeryLazy',
  --   config = function()
  --     require('rainbow-delimiters.setup').setup({})
  --   end,
  -- },

  -- WhicKey
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = require("plugins.configs.whickey"),
  },

  -- Better inputs
  {
    "stevearc/dressing.nvim",
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
    opts = {},
  },
}
