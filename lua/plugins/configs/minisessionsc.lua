return function()
  local opts = {
    -- Whether to read latest session if Neovim opened without file arguments
    autoread = false,

    -- Whether to write current session before quitting Neovim
    autowrite = true,

    -- Directory where global sessions are stored (use `''` to disable)
    -- directory = --<"session" subdir of user data directory from |stdpath()|>,
    directory = vim.fn.stdpath('config') .. '/sessions',

    -- File for local session (use `''` to disable)
    -- file = 'Session.vim',

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
  }
  require('mini.sessions').setup(opts)
end
