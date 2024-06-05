----------------------------------
--- The options
----------------------------------

local vopt = vim.opt
local vg = vim.g
local vapi = vim.api
local spf = vim.fs.joinpath(vim.fn.stdpath('config'), 'spell')

local options = {}

local globals = {}

-- Load setter
for key, valor in pairs(configs) do
  vopt[key] = valor
end
for key, valor in pairs(globals) do
  vg[key] = valor
end

--if vim.fn.executable('rg') == 1 then
opt.grepformat = '%f:%l:%c:%m,%f:%l:%m'
opt.grepprg = 'rg --vimgrep --no-heading --smart-case'
--end
