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
      config = function()
        -- height = math.floor(0.6 * vim.o.lines)
        -- width = math.floor(0.5 * vim.o.columns)
        height = 10
        width = 60
        return {
          anchor = 'NW',
          height = height,
          width = width,
          -- row = math.floor(0.5 * (vim.o.lines - height)),
          row = 1,
          col = math.floor(0.5 * (vim.o.columns - width)),
          -- border = 'double',
          border = 'solid',
        }
      end,

      -- String to use as cursor in prompt
      prompt_cursor = '▏',

      -- String to use as prefix in prompt
      prompt_prefix = '> ',
    },
  }
  minipick.setup(opts)
  -- Extra picks: lsp, etc
  require('mini.extra').setup()

  -- TODO: add the way to list the files from the original dir, restore the dir when go out of nettree
  -- TODO: add spect to list the buffers in the new order
  -- local pick = require('mini.pick')

  -- TODO: selector for registry
  minipick.registry.registry = function()
    local items = vim.tbl_keys(MiniPick.registry)
    table.sort(items)
    local source = { items = items, name = 'Registry', choose = function() end }
    local chosen_picker_name = MiniPick.start({ source = source })
    if chosen_picker_name == nil then
      return
    end
    return MiniPick.registry[chosen_picker_name]()
  end

  -- TODO: Buffers List
  minipick.registry.bufferlist = function()
    local buffers_output = vim.api.nvim_exec('buffers', true)
    local curbuf = vim.api.nvim_get_current_buf()
    local curbuf_name = 'Buffers L'
    local items = {}
    --- visit order
    local order = _G._kernel._bufferslist
    --- Iterator
    -- vim.notify(vim.inspect(buffers_output))
    for line in string.gmatch(buffers_output, '[^\n]+') do
      local buf_num = tonumber(line:match('%d+') or 0)
      local buf_relname = line:match('"([^"]+)"')
      -- Try to skip actual buffer
      if buf_num == curbuf then
        curbuf_name = buf_num .. ' ' .. buf_relname
      else
        local buf_filename = buf_relname:match('([^/]+)$')
        local buf_relpath = buf_relname:match('(.*/)') or ''
        -- local flag = (bfactual == buf_num and '%' or (bfaltternate == buf_num and '#' or ' '))
        table.insert(items, {
          buf = buf_num,
          -- name = buf_relname,
          -- text = buf_relname,
          -- text = buf_relname,
          -- text = buf_filename,
          text = ' ' .. buf_filename .. ' \n ' .. buf_relpath,
          -- filename = buf_filename,
          -- pathname = buf_relpath,
          -- -- flag = flag,
          time = order[buf_num] or -1,
        })
      end
    end

    -- Sort items
    table.sort(items, function(a, b)
      return a.time > b.time
    end)
    local source = {
      items = items,
      name = curbuf_name,
      -- choose = function()end
      show = function(buf_id, items, query)
        MiniPick.default_show(buf_id, items, query, { show_icons = true })
      end,
      -- show = function(buf_id, items_arr, query)
      --   local lines = vim.tbl_map(function(x)
      --     -- return 'Item: ' .. x.text
      --     return x.text
      --   end, items_arr)
      --   vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, lines)
      -- end,
    }
    MiniPick.start({ source = source })

    -- -- all existing bufers
    -- local buffers_list = vim.api.nvim_list_bufs()
    -- -- Utils
    -- local alternate_buf = vim.fn.bufnr('#')
    -- local actual_buf = vim.fn.bufnr('')
    -- local cwd = vim.fn.getcwd()
    -- -- Used buffers
    -- local buffer_items = {}
    --
    -- for _, buf_num in ipairs(buffers_list) do
    --   if vim.fn.buflisted(bfnr) ~= 0 then
    --     goto continue
    --   end
    --   if actual_buf == buf_num then
    --     goto continue
    --   end
    --
    --   local buf_fullname  = vim.api.nvim_buf_get_name(buf_num)
    --   local buf_filename = buf_fullname:match('([^/]+)$')
    --   local buf_relname  = buf_fullname:gsub("^" .. cwd, "")
    --   local buf_relpath  = buf_relname:match("(.*/).+")
    --   local flag = (bfactual == bfnr and '%' or (bfaltternate == bfnr and '#' or ' '))
    --   table.insert(buffer_items,{
    --     buf = buf_num,
    --     fullpath = buf_fullname,
    --     file = buffer_items,
    --     relpath = buf_relpath,
    --     time = order[buf_num] or -1,
    --     flag = flag
    --   })
    --     --- Catch when is skipped
    --   ::continue::
    -- end
    --
    -- table.sort(buffer_items, function(a,b)
    --   return a.time > b.time
    -- end)
    --
    -- local source = {
    --   items = buffer_items,
    --   name = "Buffers L",
    --   -- choose = function()end
    --   show = function(buf_id, items, query) MiniPick.default_show(buf_id, items, query, { show_icons = true }) end
    -- }
    -- MiniPick.start({source = source})
  end

  -- TODO: add manager for a tabs (could work like 'dedicated spaces')
  -- TODO: selector for sessions

  -- TODO: validate if the sessions is mini session
  minipick.registry.sessions = function()
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
