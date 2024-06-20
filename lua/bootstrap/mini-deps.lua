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

-- reset package path
vim.opt.pp={
  "~/.local/share/nvim/site",
  "/usr/local/share/nvim/runtime"
}

-- ~/.config/nvim
-- /etc/xdg/nvim
-- ~/.local/share/nvim/site
-- ~/.local/share/flatpak/exports/share/nvim/site
-- /var/lib/flatpak/exports/share/nvim/site
-- /usr/local/share/nvim/site
-- /usr/share/nvim/site
-- /var/lib/snapd/desktop/nvim/site
-- /usr/local/share/nvim/runtime
-- /usr/local/lib64/nvim
-- /var/lib/snapd/desktop/nvim/site/after
-- /usr/share/nvim/site/after
-- /usr/local/share/nvim/site/after
-- /var/lib/flatpak/exports/share/nvim/site/after
-- ~/.local/share/flatpak/exports/share/nvim/site/after
-- ~/.local/share/nvim/site/after
-- /etc/xdg/nvim/after
-- ~/.config/nvim/after

--- Reset rtp
-- ~/.config/nvim
-- /etc/xdg/nvim
-- ~/.local/share/nvim/site
-- ~/.local/share/nvim/site/pack/*/start/*
-- ~/.local/share/flatpak/exports/share/nvim/site
-- /var/lib/flatpak/exports/share/nvim/site
-- /usr/local/share/nvim/site
-- /usr/share/nvim/site
-- /var/lib/snapd/desktop/nvim/site
-- /usr/local/share/nvim/runtime
-- /usr/local/share/nvim/runtime/pack/dist/opt/matchit
-- /usr/local/lib64/nvim
-- ~/.local/share/nvim/site/pack/*/start/*
-- /var/lib/snapd/desktop/nvim/site/after
-- /usr/share/nvim/site/after
-- /usr/local/share/nvim/site/after
-- /var/lib/flatpak/exports/share/nvim/site/after
-- ~/.local/share/flatpak/exports/share/nvim/site/after
-- ~/.local/share/nvim/site/after
-- /etc/xdg/nvim/after
-- ~/.config/nvim/after

--- TO
-- ~/.config/nvim
-- ~/.local/share/nvim/site
-- ~/.local/share/nvim/lazy/lazy.nvim
-- ~/.local/share/nvim/lazy/nvim-ts-autotag
-- ~/.local/share/nvim/lazy/plenary.nvim
-- ~/.local/share/nvim/lazy/nui.nvim
-- ~/.local/share/nvim/lazy/hardtime.nvim
-- ~/.local/share/nvim/lazy/nvim-treesitter
-- /usr/local/share/nvim/runtime
-- /usr/local/share/nvim/runtime/pack/dist/opt/matchit
-- ~/.config/nvim/after
-- ~/.local/state/nvim/lazy/readme

-- vim.opt.rtp:prepend(lazypath)

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

require('mini-deps-plugins')
