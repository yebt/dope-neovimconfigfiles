local opt = vim.opt
local cache_dir = vim.env.HOME .. '/.cache/nvim/'

local configs = {
  compatible = false,

  backspace = 'indent,eol,start,nostop',
  --# Wrap
  -- wrap = false,
  linebreak = true,
  whichwrap = 'h,l,<,>,[,],~',
  breakindentopt = 'shift:2,min:20', -- "min:40,shift:0,sbr",
  breakindent = true,
  showbreak = '↳ ',
  --# Indent
  copyindent = true,
  preserveindent = true,
  smartindent = true,
  smarttab = true,
  autoindent = true,
  --# Tabs
  expandtab=true,
  shiftwidth = 4,
  tabstop = 4,
  softtabstop = 4,
  --# Cursor
  cursorline = true,
  guicursor = 'a:block-cursor',
  virtualedit = 'block',
  --# Conceal
  concealcursor = 'nc',
  -- conceallevel = 2,
  --# Buffer
  hidden = true,
  magic = true,
  confirm = true,
  clipboard = 'unnamed', -- unnamedplus, unnamed
  --# Search
  wildignorecase = true,
  ignorecase = true,
  smartcase = true,
  infercase = true,
  --# Files
  swapfile = false,
  directory = cache_dir .. 'swap/',
  undodir = cache_dir .. 'undo/',
  backupdir = cache_dir .. 'backup/',
  viewdir = cache_dir .. 'view/',
  spellfile = cache_dir .. 'spell/en.uft-8.add' .. ',' .. cache_dir .. 'spell/es.uft-8.add',
  undofile = true,
  --# Spell
  spelllang = 'en,es',
  spelloptions = 'camel',
  --# Column
  number = true,
  relativenumber = true,
  --# Fold
  -- foldenable= true,
  foldlevelstart = 99,
  foldmethod = 'marker', -- marker, indent
  -- foldmethod = 'indent',-- marker, indent
  foldcolumn = '1',
  --# Sign
  signcolumn = 'yes', -- yes auto
  --# Paragrap
  textwidth = 100,
  colorcolumn = '100',
  --# CMD
  cmdheight = 0, -- 0,2
  history = 2000,
  showmode = false,
  -- shortmess = 'aoOTIcF',
  shortmess = {
    -- f = true, -- use "(3 of 5)" instead of "(file 3 of 5)"		*shm-f*
    -- i = true, -- use "[noeol]" instead of "[Incomplete last line]"	*shm-i*
    -- l = true, -- use "999L, 888B" instead of "999 lines, 888 bytes"	*shm-l*
    -- n = true, -- use "[New]" instead of "[New File]"			*shm-n*
    -- x = true, -- use "[dos]" instead of "[dos format]", "[unix]"	instead of "[unix format]" and "[mac]" instead of "[macformat]" *shm-x*
    -- t = true, -- truncate file message at the start if it is too long	to fit on the command-line, "<" will appear in the left most column; ignored in Ex mode *shm-t*
    T = true, -- truncate other messages in the middle if they are too 	long to fit on the command line; "..." will appear in the middle; ignored in Ex mode *shm-T*
    I = true, -- hiddetn intro messages -- is not needed cause use start session
    o = true, -- overwrite message for writing a file with subsequent message for reading a file (useful for ":wn" or when 'autowrite' on) O	message for reading a file overwri
    O = true, -- message for reading a file overwrites any previous	message;  also for quickfix message (e.g., ":cn")
    F = true, -- don't give the file info when editing a file, like	`:silent` was used for the command
    c = true, --	don't give |ins-completion-menu| messages; for		*shm-c*
    --
    a = true, -- all short
  },
  showtabline = 0,
  --# Split
  splitbelow = true,
  splitright = true,
  splitkeep = 'screen',
  inccommand = 'split',
  --
  winwidth = 30, -- to collapse
  pumheight = 15,
  -- pumblend= 10, -- pseudo-transparency
  -- winblend = 10, -- pseudo-transparency in win
  showcmd = false,
  --#
  laststatus = 3,
  ruler = false,
  --# Miselaneous
  -- completeopt = 'menu,menuone,noselect', --
  completeopt = {
    'menu',
    'menuone',
    'noselect',
    'noinsert',
  },
  --# Time
  timeout = true,
  ttimeout = true,
  timeoutlen = 500,
  ttimeoutlen = 10,
  updatetime = 100,
  redrawtime = 1500,
  --# Colors
  termguicolors = true,
  -- background="dark",
  --# Scroll
  scrolloff = 2,
  sidescrolloff = 5,
  sessionoptions = 'buffers,curdir,winsize',
  viewoptions = 'folds,cursor',
  --# chars
  list = true,
  listchars = 'tab:»·,nbsp:+,trail:·,extends:→,precedes:←',
  --# Fills
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
  --# Diffs
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
  --# Cpoptions
  cpoptions = {
    -- a = true, -- When included, a ":read" command with a file name argument will set the alternate file name for the current window.
    -- b = true, -- When included, a ":write" command with a file name argument will set the alternate file name for the current window.
    -- B = true, -- A backslash has no special meaning in mappings, abbreviations, user commands and the "to" part of the menu commands.  Remove this flag to be able to use a backslash like a CTRL-V.  For example, the command
    -- --		   ":map X \<Esc>" results in X being mapped to:
    -- --		   'B' included:	"\^["	 (^[ is a real <Esc>)
    -- --		   'B' excluded:	"<Esc>"  (5 characters)
    -- c = true, -- Searching continues at the end of any match at the cursor position, but not further than the start of the next line.  When not present searching continues one character from the cursor position.  With 'c' "abababababab" only gets three matches when repeating "/abab", without 'c' there are five matches.
    -- e = true, -- When executing a register with ":@r", always add a <CR> to the last line, also when the register is not linewise.  If this flag is not present, the register is not linewise and the last line does not end in a <CR>, then the last line is put on the command-line and can be edited before hitting <CR>.
    -- F = true, -- When included, a ":write" command with a file name argument will set the file name for the current buffer, if the current buffer doesn't have a file name yet.  Also see |cpo-P|.
    n = true, -- When included, the column used for 'number' and 'relativenumber' will also be used for text of wrapped lines.
    s = true, -- Set buffer options when entering the buffer for the first time.  This is like it is in Vim version 3.0. And it is the default.  If not present the options are set when the buffer is created.
    ['_'] = true, -- When using |cw| on a word, do not include the whitespace following the word in the motion.
  },
}

local globals = {
  spellfile_URL = 'https://ftp.nluug.nl/vim/runtime/spell',
  --
  loaded_perl_provider = 0,
  loaded_ruby_provider = 0,
  --
  -- netrw_browse_split = 4,
  netrw_banner = 0,
  netrw_use_errorwindow = 0,
  netrw_windize = 35,
  netrw_keepdir = 0,
}

-- Setters
for key, valor in pairs(configs) do
  vim.opt[key] = valor
  -- vim.g.spellfile_URL = "https://ftp.nluug.nl/vim/runtime/spell" ---------
end
for key, valor in pairs(globals) do
  vim.g[key] = valor
end

-- rg
if vim.fn.executable('rg') == 1 then
  opt.grepformat = '%f:%l:%c:%m,%f:%l:%m'
  opt.grepprg = 'rg --vimgrep --no-heading --smart-case'
end

if vim.loop.os_uname().sysname == 'Darwin' then
  vim.g.clipboard = {
    name = 'macOS-clipboard',
    copy = {
      ['+'] = 'pbcopy',
      ['*'] = 'pbcopy',
    },
    paste = {
      ['+'] = 'pbpaste',
      ['*'] = 'pbpaste',
    },
    cache_enabled = 0,
  }
  vim.g.python_host_prog = '/usr/bin/python'
  vim.g.python3_host_prog = '/usr/local/bin/python3'
end
