----------------------------------
--- The options
----------------------------------

local vopt = vim.opt
local vg = vim.g
local vapi = vim.api
local spf = vim.fs.joinpath(vim.fn.stdpath('config'), 'spell')

local options = {

  -- Cursor
  cursorline = true,
  guicursor = 'a:block-cursor',
  virtualedit = 'block',

  -- Tab
  expandtab = true,
  shiftwidth = 4,
  tabstop = 4,
  softtabstop = 4,

  -- Indentation
  copyindent = true,
  preserveindent = true,
  smartindent = true,
  smarttab = true,
  autoindent = true,

  -- Wrap
  linebreak = true,
  breakindentopt = 'shift:2,min:20', --"min:40, shift:0,sbr"
  breakindent = true,
  showbreak = '↳ ',

  -- File
  -- autowrite = true,
  autoread = true,
  backup = false,
  writebackup = false,
  backupdir = vim.fs.joinpath(vim.fn.stdpath('config'), '.backups'),
  swapfile = false,
  undofile = true,

  -- Spell
  spelllang = 'en,es',
  spelloptions = 'camel',
  spellfile = {
    vim.fs.joinpath(vim.fn.stdpath('config'), 'spell/en.utf-8.add'),
    vim.fs.joinpath(vim.fn.stdpath('config'), 'spell/es.utf-8.add'),
  },

  -- View
  background = 'dark',
  termguicolors = true,
  fillchars = {
    diff = '╱',
    -- 
    -- 
    -- foldclose = "",
    -- foldopen = "",
    -- foldsep = "│"
    -- foldsep = "▏"
    -- diff = "",
  },
  laststatus = 3,
  ruler = false,
  winwidth = 30,
  showtabline = 2,

  -- Split
  splitbelow = true,
  splitright = true,
  splitkeep = 'screen',
  inccommand = 'split',

  -- CMD
  cmdheight = 1,
  cmdwinheight = 8,
  showcmd = true,

  shortmess = {
    T = true,
    o = true,
    O = tre,
    F = true,
    c = true,
    a = true,
  },

  -- Columns
  number = true,
  relativenumber = true,

  -- Fold
  foldenable = true,
  foldlevelstart = 99,
  foldmethod = 'indent', -- marker, indent
  foldcolumn = '1',

  -- Sign
  signcolumn = 'yes',

  -- Text
  textwidth = 100,
  colorcolumn = '100',

  list = true,
  listchars = 'tab:»·,nbsp:+,trail:·,extends:→,precedes:←',

  -- Conceal
  concealcursor = 'nc',
  conceallevel = 2,

  -- Buffer
  hidden = true,
  magic = true,
  confirm = true,
  clipboard = 'unnamed',

  -- Search
  ignorecase = true,
  wildignorecase = true, -- ignorecase files
  smartcase = true,
  incsearch = true,

  -- Dirs
  -- autochdir=true, -- change the dir to file dir

  -- Editing
  backspace = 'indent,eol,start,nostop',
  diffopt = {
    'filler', -- sync text content
    -- "horizontal", -- use horizontal views -
    'closeoff', -- off diff on just 1 window
    --"followwrap",
    -- "internal",
    'linematch:60', --
    --  myers      the default algorithm
    -- minimal    spend extra time to generate the
    -- smallest possible diff
    -- patience   patience diff algorithm
    -- histogram  histogram diff algorithm
    -- "algorithm:histogram"
  },

  -- Usage
  clipboard = 'unnamed',
  compatible = false,
  whichwrap = 'h,l,<,>,[,],~',
  confirm = true,
  cpoptions = {
    n = true, -- use number for wrap number
    s = true, -- set options on load buffer
    ['_'] = atrue, -- not cut the white space nex to word when press cw
  },
  sessionoptions = 'buffers,curdir,winsize',
  viewoptions = 'folds,cursor',

  -- Time
  timeout = true,
  ttimeout = true,
  timeoutlen = 500,
  ttimeoutlen = 10,
  updatetime = 100,
  redrawtime = 1500,

  -- Scroll
  scrolloff = 2,
  sidescrolloff = 5,

  -- Completionos
  complete = '.,k,w,b,u,t',
  completeopt = {
    'menu',
    'menuone',
    -- 'preview',-- show extra info in preview windows
    'popup', -- show extra info in a popup winndow
    'noinsert',
    'noselect',
    -- 'fuzzy' -- is not in nvim 10
  },
  pumheight = 15,
}

local globals = {
  loaded_perl_provider = 0,
  loaded_ruby_provider = 0,
  --
  -- netrw_browse_split = 4,
  netrw_banner = 0,
  netrw_use_errorwindow = 0,
  netrw_windize = 35,
  netrw_keepdir = 0,
}

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