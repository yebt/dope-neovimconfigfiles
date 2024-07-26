return function()
  local minipick = require('mini.pick')
  local opts = {
    delay = {
      -- Delay between forcing asynchronous behavior
      async = 10,
      -- Delay between computation start and visual feedback about it
      busy = 50,
    },
    -- Keys for performing actions. See `:h MiniPick-actions`.
    mappings = {
      caret_left = '<Left>',
      caret_right = '<Right>',

      choose = '<CR>',
      choose_in_split = '<C-s>',
      choose_in_tabpage = '<C-t>',
      choose_in_vsplit = '<C-v>',
      choose_marked = '<M-CR>',

      delete_char = '<BS>',
      delete_char_right = '<Del>',
      delete_left = '<C-u>',
      delete_word = '<C-w>',

      mark = '<C-x>',
      mark_all = '<C-a>',

      move_down = '<C-n>',
      move_start = '<C-g>',
      move_up = '<C-p>',

      paste = '<C-r>',

      refine = '<C-Space>',
      refine_marked = '<M-Space>',

      scroll_down = '<C-f>',
      scroll_left = '<C-h>',
      scroll_right = '<C-l>',
      scroll_up = '<C-b>',

      stop = '<Esc>',

      toggle_info = '<S-Tab>',
      toggle_preview = '<Tab>',
    },

    -- General options
    options = {
      -- Whether to show content from bottom to top
      content_from_bottom = false,
      -- Whether to cache matches (more speed and memory on repeated prompts)
      use_cache = true,
    },
    -- Window related options
    window = {
      -- Float window config (table or callable returning it)
      -- config = function()
      --   -- height = math.floor(0.6 * vim.o.lines)
      --   -- width = math.floor(0.5 * vim.o.columns)
      --   height = 10
      --   width = 60
      --   return {
      --     anchor = 'NW',
      --     height = height,
      --     width = width,
      --     -- row = math.floor(0.5 * (vim.o.lines - height)),
      --     row = 1,
      --     col = math.floor(0.5 * (vim.o.columns - width)),
      --     border = 'double',
      --   }
      -- end,

      -- String to use as cursor in prompt
      prompt_cursor = '▏',

      -- String to use as prefix in prompt
      prompt_prefix = '> ',
    },
  }
  minipick.setup(opts)
end
