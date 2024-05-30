----------------------------------
--- This file contain pack
--- of packa manangment starter
----------------------------------

local uv, api, fn = vim.loop, vim.api, vim.fn
local pack = {}
pack.__index = pack

function pack:load_modules_packages()
  --local modules_dir = self.helper.path_join(self.config_path, 'lua', 'modules')
  ---@diagnostic disable-next-line: param-type-mismatch
  local modules_dir = vim.fs.joinpath(self.config_path, 'lua', 'modules')
  self.repos = {}

  local list = vim.fs.find('package.lua', { path = modules_dir, type = 'file', limit = 10 })
  if #list == 0 then
    return
  end

  -- local disable_modules = {}

  -- if fn.exists('g:disable_modules') == 1 then
  --   disable_modules = vim.split(vim.g.disable_modules, ',', { trimempty = true })
  -- end

  -- for _, f in pairs(list) do
  --   local _, pos = f:find(modules_dir)
  --   f = f:sub(pos - 6, #f - 4)
  --   if not vim.tbl_contains(disable_modules, f) then
  --     require(f)
  --   end
  -- end
  vim.iter(list):map(function(f)
    local _, pos = f:find(modules_dir)
    f = f:sub(pos - 6, #f - 4)
    require(f)
  end)
end

function pack:boot_strap()
  self.helper = require('core.helper')
  self.data_path = self.helper.data_path()
  self.config_path = self.helper.config_path()
  -- local lazy_path = self.helper.path_join(self.data_path, 'lazy', 'lazy.nvim')
  ---@diagnostic disable-next-line: param-type-mismatch
  local lazy_path = vim.fs.joinpath(self.data_path, 'lazy', 'lazy.nvim')

  local state = uv.fs_stat(lazy_path)
  if not state then
    local cmd = '!git clone https://github.com/folke/lazy.nvim.git ' .. lazy_path
    api.nvim_command(cmd)
  end
  vim.opt.runtimepath:prepend(lazy_path)
  local lazy = require('lazy')
  self:load_modules_packages()

  local opts = {
    -- lockfile = self.helper.path_join(self.data_path, 'lazy-lock.json'),
    ---@diagnostic disable-next-line: param-type-mismatch
    lockfile = vim.fs.joinpath(self.data_path, 'lazy-lock.json'),

    defaults = {
      lazy = true, -- should plugins be lazy-loaded?
    },
    ui = {
      -- a number <1 is a percentage., >1 is a fixed size
      size = { width = 0.8, height = 0.8 },
      -- pills = false,
    },
    checker = {
      -- automatically check for plugin updates
      enabled = true,
      notify = false, -- get a notification when new updates are found
      frequency = 3600, -- check for updates every hour
      check_pinned = false, -- check for pinned packages that can't be updated
    },
    change_detection = {
      -- automatically check for config file changes and reload the ui
      enabled = false,
      notify = true, -- get a notification when changes are found
    },
    performance = {
      cache = {
        enabled = true,
      },
      reset_packpath = true,
      rtp = {
        reset = _G.walo.reset_rtp,
        ---@type string[]
        paths = {}, -- add any custom paths here that you want to includes in the rtp
        ---@type string[] list any plugins you want to disable here
        disabled_plugins = {
          'gzip',
          --'matchit',
          -- 'matchparen',
          -- 'netrwPlugin',
          'tarPlugin',
          'tohtml',
          'tutor',
          'zipPlugin',
          'man',
          'osc52',
          'shada',
          -- 'editorconfig',
        },
      },
    },
    -- profiling = {
    --   -- Enables extra stats on the debug tab related to the loader cache.
    --   -- Additionally gathers stats about all package.loaders
    --   loader = true,
    --   -- Track each new require in the Lazy profiling tab
    --   require = true,
    -- },
  }
  lazy.setup(self.repos, opts)

  -- -- for k, v in pairs(self) do
  -- --   if type(v) ~= 'function' then
  -- --     self[k] = nil
  -- --   end
  -- -- end
end

-- function pack.package(repo)
--   if not pack.repos then
--     pack.repos = {}
--   end
--   table.insert(pack.repos, repo)
-- end
_G.packadd = function(repo)
  if not pack.repos then
    pack.repos = {}
  end

  pack.repos[#pack.repos + 1] = repo
end

return pack
