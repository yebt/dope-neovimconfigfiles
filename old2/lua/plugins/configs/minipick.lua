return function()
  local opts = -- No need to copy this inside `setup()`. Will be used automatically.
    {
      -- Delays (in ms; should be at least 1)
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
        -- content_from_bottom = true,

        -- Whether to cache matches (more speed and memory on repeated prompts)
        use_cache = false,
      },

      -- Source definition. See `:h MiniPick-source`.
      source = {
        items = nil,
        name = nil,
        cwd = nil,

        match = nil,
        show = nil,
        preview = nil,

        choose = nil,
        choose_marked = nil,
      },

      -- Window related options
      window = {
        -- Float window config (table or callable returning it)
        config = {
          -- relative = 'win',
          relative = 'editor',
          -- width=120,
          height = 10,
          -- border="none",
          border = 'solid',
          -- win = 1001,
          row = 10,
          col = 20,
          -- zindex=zindex,
        },

        -- String to use as cursor in prompt
        prompt_cursor = '▏',

        -- String to use as prefix in prompt
        prompt_prefix = '> ',
      },
    }
  require('mini.visits').setup()
  require('mini.extra').setup()
  local pick = require('mini.pick')
  pick.setup(opts)

  pick.registry.registry = function()
    local items = vim.tbl_keys(MiniPick.registry)
    table.sort(items)
    local source = { items = items, name = 'Registry', choose = function() end }
    local chosen_picker_name = MiniPick.start({ source = source })
    if chosen_picker_name == nil then
      return
    end
    return MiniPick.registry[chosen_picker_name]()
  end

  pick.registry.sessions = function()
    local items = vim.tbl_keys(require('mini.sessions').detected)
    local fitems = {}

    for indx, el in ipairs(items) do
      local els = vim.split(el, ' ')
      local name = els[1]
      local path = els[2] and '  -> ' .. els[2] or ''
      path = path:gsub('%%', '/')
      table.insert(fitems, name .. path)
    end
    -- table.sort(fitems)
    local source = { items = fitems, name = 'Sessions', choose = function() end }
    local chosen_picker_session = MiniPick.start({ source = source })
    -- local items = vim.tbl_keys(MiniPick.registry)
    -- table.sort(items)
    -- local source = { items = items, name = 'Registry', choose = function() end }
    -- local chosen_picker_name = MiniPick.start({ source = source })
    -- if chosen_picker_name == nil then
    --   return
    -- end
    -- return MiniPick.registry[chosen_picker_name]()
  end
end
