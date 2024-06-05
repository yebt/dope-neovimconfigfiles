----------------------------------
--- The options
----------------------------------

local vopt = vim.opt
local vg = vim.g
local vapi = vim.api
local spf = vim.fs.joinpath(vim.fn.stdpath('config'), 'spell')

local options = {

  -- Indentation
  autoindent = true,
  linebreak = true,
  breakindentopt = 'shift:2,min:20', --"min:40, shift:0,sbr"
  -- File
  autoread = true,
  -- autowrite = true,
  backup = true,
  writebackup = true,
  -- backupdir = "",

  -- View
  background = 'dark',

  -- Dirs
  -- autochdir=true, -- change the dir to file dir

  -- Editing
  backspace = 'indent,eol,start,nostop',

  -- Usage
  clipboard = 'unnamed',
  compatible = false,
  whichwrap = 'h,l,<,>,[,],~',
}

local globals = {}

-- Load setter
for key, valor in pairs(options) do
  vopt[key] = valor
end
for key, valor in pairs(globals) do
  vg[key] = valor
end

--if vim.fn.executable('rg') == 1 then
vopt.grepformat = '%f:%l:%c:%m,%f:%l:%m'
vopt.grepprg = 'rg --vimgrep --no-heading --smart-case'
--end
