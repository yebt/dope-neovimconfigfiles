--- ----------------------------------------
--- This contain the configs for the basic
--- usage of the neovim
--- ----------------------------------------

---
local vopt = vim.opt
local vg = vim.g
local vapi = vim.api
local spf = vim.fs.joinpath(vim.fn.stdpath('config'), 'spell')

--- OPTIONS VAR LOOP
local options = {

  -- Cursor
  cursorline = true, -- show cursor line highlights:
  guicursor = 'a:block-cursor', -- show the cursor in block in any mode
  virtualedit = 'block', --

  -- Sizes
  winwidth = 60,
  winminwidth = 10,
  -- winheight=30,
  -- winminheight = 20,

  -- Tab
  expandtab = true, -- convert tabs  in spaces
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
    foldclose = '',
    foldopen = '',
    -- foldsep = "│",
    foldsep = '▏',
    -- diff = "",
  },

  ruler = true,
  showtabline = 2, -- always
  tabpagemax = 15,
  -- tabline='%0*%#TabLine#%#TabLineSel#> %<%f %h%m%r %0*'
  -- tabline='%#TabLine# %#TabLineSel#> %<%f %#WarningMsg#%h%m%r %#TabLineFill#',
  -- laststatus = 3,
  -- statuscolumn
  -- statusline
  -- statusline = " ",

  -- Split
  splitbelow = true,
  splitright = true,
  splitkeep = 'screen',
  inccommand = 'split',

  -- CMD
  cmdheight = 1,
  -- cmdwinheight = 8,
  showcmd = true,
  showmode = false,

  -- Short
  shortmess = {
    a = true, -- abbreviate all messages
    o = true, -- overwite write message
    O = true, --
    T = true, -- trunkate messages ...
    F = true,
    c = true, -- now show autocmpletion print
    --   I = true, -- not get intro message
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
  -- signcolumn = 'yes',
  -- signcolumn = 'yes:1',
  signcolumn = 'auto:4',

  -- Text
  textwidth = 100,
  -- colorcolumn = '100',

  -- Format
  formatoptions = {
    t = true, -- Autowrap textwidth
    c = true, -- Autowrapp comments with textwidth
    q = true, -- Allow formating comments with gq
    j = true, -- Where it makes sense, remove a comment leader when joining lines.
  },

  list = true,
  -- listchars = 'tab:»·,nbsp:+,trail:·,vextends:→,precedes:←',
  listchars = {
    -- eol='¶',
    -- eol='¬',
    -- eol = '↴',
    -- tab='»·',
    tab = '⤚·',
    -- tab='⇤–⇥',
    -- tab='├→',
    -- tab='│ ',
    -- tab='>·',
    nbsp = '+',
    -- lead='·',
    trail = '·',
    extends = '→',
    -- precedes = '←',
  },

  -- Conceal
  concealcursor = 'nc',
  conceallevel = 2,

  -- Buffer
  hidden = true,
  magic = true,

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

  -- -- Usage
  clipboard = 'unnamed',
  compatible = false,
  whichwrap = 'h,l,<,>,[,],~',
  -- confirm = true,
  cpoptions = {
    a = true, -- change windows name with the read comman file name
    A = true, -- change windows name with the write comman file name
    B = true, -- No special meaning of backslash in the maps
    c = true, -- Searching continues at the end of any match at the cursor
    e = true, -- Add CR to last line wjen executing a register with ":@r"
    F = true, -- When included, a ":write" command a filename set filename to buffer
    s = true, -- Set the buffer options for first time
    --
    -- n = true, -- use number for wrap number
    ['_'] = true, -- not cut the white space nex to word when press cw
  },
  -- sessionoptions = 'buffers,curdir,winsize',
  sessionoptions = {
    'buffers',
    'curdir',
    'tabpages',
    'winpos',
    'winsize',
    -- 'folds',
  },

  viewoptions = 'folds,cursor',

  -- Time
  timeout = true, -- timeout for maps
  ttimeout = true, --timeout for tui like ESC
  timeoutlen = 500,
  ttimeoutlen = 10,
  updatetime = 500, -- 4000 -- cursor hold event
  -- redrawtime = 1500, -- 2000 -- time for redraw by hlsearch, incoomand and match

  -- Scroll
  scroll = 4, -- quentity of lines scrolled
  scrolloff = 2, -- lines like a gap when scroll, if is 0, the scroll occourse when cursor es in the limit
  -- sidescrolloff = 5,

  -- Completionos
  complete = '.,k,w,b,u,t',
  completeopt = {
    'menu',
    'menuone',
    'preview', -- show extra info in preview windows -- not complatible with preview
    -- 'popup', -- show extra info in a popup winndow
    --- Sometimes i need insert the selected options when i trigger it manually
    -- 'noinsert',
    -- 'noselect',
    -- 'fuzzy' -- is not in nvim 10
  },
  -- pumheight = 15,
}

--- VARS GLOBAL LOOP
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

--- Load setter
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
-- vim.cmd([[
--
-- set tabline=%!MyTabLine()
-- if exists("+showtabline")
--     function! MyTabLine()
--         let s = ''
--         let wn = ''
--         let t = tabpagenr()
--         let i = 1
--         while i <= tabpagenr('$')
--             let buflist = tabpagebuflist(i)
--             let winnr = tabpagewinnr(i)
--             let s .= '%' . i . 'T'
--             let s .= (i == t ?  '%1*' : '%2*')
--             let s .= ' '
--             let wn = tabpagewinnr(i,'$')
--
--             let s .= (i== t ? '%#TabNumSel#' : '%#TabNum#')
--             let s .= i
--             if tabpagewinnr(i,'$') > 1
--                 let s .= '.'
--                 let s .= (i== t ? '%#TabWinNumSel#' : '%#TabWinNum#')
--                 let s .= (tabpagewinnr(i,'$') > 1 ? wn : '')
--             end
--
--             let s .= ' %*'
--             let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
--             let bufnr = buflist[winnr - 1]
--             let file = bufname(bufnr)
--             let buftype = getbufvar(bufnr, 'buftype')
--             if buftype == 'nofile'
--                 if file =~ '\/.'
--                     let file = substitute(file, '.*\/\ze.', '', '')
--                 endif
--             else
--                 let file = fnamemodify(file, ':p:t')
--             endif
--             if file == ''
--                 let file = '[No Name]'
--             endif
--             let s .= file
--             let s .= (i == t ?  '%m' : '')
--             let i = i + 1
--         endwhile
--         let s .= '%T%#TabLineFill#%='
--         return s
--     endfunction
--     set stal=2
--     set tabline=%!MyTabLine()
-- endif
--
-- "function MyTabLabel(n)
-- "  let buflist = tabpagebuflist(a:n)
-- "  let winnr = tabpagewinnr(a:n)
-- "  return bufname(buflist[winnr - 1])
-- "endfunction
-- "function MyTabLine()
-- "  let s = ''
-- "  for i in range(tabpagenr('$'))
-- "    " select the highlighting
-- "    if i + 1 == tabpagenr()
-- "      let s ..= '%#TabLineSel#'
-- "    else
-- "      let s ..= '%#TabLine#'
-- "    endif
-- "
-- "    " set the tab page number (for mouse clicks)
-- "    let s ..= '%' .. (i + 1) .. 'T'
-- "
-- "    " the label is made by MyTabLabel()
-- "    let s ..= ' %{MyTabLabel(' .. (i + 1) .. ')} '
-- "  endfor
-- "
-- "  " after the last tab fill with TabLineFill and reset tab page nr
-- "  let s ..= '%#TabLineFill#%T'
-- "
-- "  " right-align the label to close the current tab page
-- "  if tabpagenr('$') > 1
-- "    let s ..= '%=%#TabLine#%999Xclose'
-- "  endif
-- "
-- "  return s
-- "endfunction
-- ]])
