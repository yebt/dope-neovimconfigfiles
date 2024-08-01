---  HERE: Plugins to make like a IDE or editor experience
local selected_plugin = require('util.functions').selected_plugin
return {

  --- Iterator
  {
    'folke/trouble.nvim',
    cmd = { 'Trouble' },
    config = require('plugins.configs.troublec'),
  },

  --- Session Manager
  {
    'echasnovski/mini.sessions',
    version = false,
    cond = selected_plugin('sessions', 'minisessions'),
    config = require('plugins.configs.minisessionsc'),
  },

  --- Indenttation
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

  --- Colorized
  {
    'NvChad/nvim-colorizer.lua',
    cmd = {
      'ColorizerAttachToBuffer',
      'ColorizerDetachFromBuffer',
      'ColorizerReloadAllBuffers',
      'ColorizerToggle',
    },
    opts = {
      filetypes = { '*' },
      user_default_options = {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        names = true, -- "Name" codes like Blue or blue
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        AARRGGBB = false, -- 0xAARRGGBB hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Available modes for `mode`: foreground, background,  virtualtext
        mode = 'background', -- Set the display mode.
        -- Available methods are false / true / "normal" / "lsp" / "both"
        -- True is same as normal
        tailwind = true, -- Enable tailwind colors
        -- parsers can contain values used in |user_default_options|
        sass = { enable = true, parsers = { 'css' } }, -- Enable sass colors
        virtualtext = '■',
        -- update color values even if buffer is not focused
        -- example use: cmp_menu, cmp_docs
        always_update = true, -- nice
      },
      -- all the sub-options of filetypes apply to buftypes
      buftypes = {},
    },
  },

  --- Sessiosn
  {
    'folke/persistence.nvim',
    cond = selected_plugin('sessions', 'persistence'),
    event = 'BufReadPre', -- this will only start session saving when an actual file was opened
    opts = {
      dir = _kernel.options.plugins.sessions_dir or nil,
      -- minimum number of file buffers that need to be open to save
      -- Set to 0 to always save
      need = 1,
      branch = true, -- use git branch to save session
    },
  },

  --- Mini Session
  {
    'echasnovski/mini.sessions',
    version = false,
    cond = selected_plugin('sessions', 'minisessions'),
    keys = {
      --- Save session
      {
        '<leader>ss',
        function()
          local uv = vim.uv or vim.loop
          local branch = nil
          if uv.fs_stat('.git') then
            local ret = vim.fn.systemlist('git branch --show-current')[1]
            branch = vim.v.shell_error == 0 and ret or nil
          end
          --
          local name = vim.fn.getcwd():gsub('[\\/:]+', '%%')
          -- Track
          if branch and branch ~= 'main' and branch ~= 'master' then
            name = name .. '%%' .. branch:gsub('[\\/:]+', '%%')
          end
          require('mini.sessions').write(name)
        end,
        desc = "Save sessions 'mini'",
      },
      -- {
      --   ""
      -- }
    },
    opts = {
      -- Whether to read latest session if Neovim opened without file arguments
      autoread = false,

      -- Whether to write current session before quitting Neovim
      autowrite = true,

      -- Directory where global sessions are stored (use `''` to disable)
      -- directory = --<"session" subdir of user data directory from |stdpath()|>,
      directory = _kernel.options.plugins.sessions_dir or nil,

      -- File for local session (use `''` to disable)
      file = 'Session.vim',

      -- Whether to force possibly harmful actions (meaning depends on function)
      force = { read = false, write = true, delete = false },

      -- Hook functions for actions. Default `nil` means 'do nothing'.
      hooks = {
        -- Before successful action
        pre = { read = nil, write = nil, delete = nil },
        -- After successful action
        post = { read = nil, write = nil, delete = nil },
      },

      -- Whether to print session path after action
      verbose = { read = true, write = true, delete = true },
    },
  },
}
