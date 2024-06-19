-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.notify("Installing `mini.nvim` in '" .. mini_path .. "'")
  vim.api.nvim__redraw({ flush = true })
  -- vim.cmd('redraw')
  --
  -- vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/echasnovski/mini.nvim',
    mini_path,
  }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.notify('Installed `mini.nvim`')
  vim.api.nvim__redraw({ flush = true })
  -- vim.cmd('redraw')
  --
  -- vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Set up 'mini.deps' (customize to your liking)
-- require('mini.deps').setup({ path = { package = path_package } })
require('mini.deps').setup({
  -- Parameters of CLI jobs
  job = {
    -- Number of parallel threads to use. Default: 80% of all available.
    n_threads = 90,

    -- Timeout (in ms) for each job before force quit
    timeout = 30000,
  },

  -- Paths describing where to store data
  path = {
    -- Directory for built-in package.
    -- All plugins are actually stored in 'pack/deps' subdirectory.
    package = path_package,

    -- Default file path for a snapshot
    snapshot = vim.fn.stdpath('config') .. '/mini-deps-snap',

    -- Log file
    log = vim.fn.stdpath('log') .. '/mini-deps.log',
  },

  -- Whether to disable showing non-error feedback
  silent = false,
})

require('miniplugins')

vim.schedule(function()
  vim.api.nvim_exec_autocmds('User', { pattern = 'PostPlugins' })
end)
