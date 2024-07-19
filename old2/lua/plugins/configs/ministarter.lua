return function()
  -- Configuration similar to 'mhinz/vim-startify':
  -- local starter = require('mini.starter')
  -- starter.setup({
  --   evaluate_single = true,
  --   items = {
  --     starter.sections.builtin_actions(),
  --     starter.sections.recent_files(10, false),
  --     starter.sections.recent_files(10, true),
  --     -- Use this if you set up 'mini.sessions'
  --     starter.sections.sessions(5, true)
  --   },
  --   content_hooks = {
  --     starter.gen_hook.adding_bullet(),
  --     starter.gen_hook.indexing('all', { 'Builtin actions' }),
  --     starter.gen_hook.padding(3, 2),
  --   },
  -- })

  -- configuration similar to 'glepnir/dashboard-nvim':
  -- local starter = require('mini.starter')
  -- starter.setup({
  --   items = {
  --     starter.sections.telescope(),
  --   },
  --   content_hooks = {
  --     starter.gen_hook.adding_bullet(),
  --     starter.gen_hook.aligning('center', 'center'),
  --   },
  -- })

  -- Default
  -- require('mini.starter').setup()
  --

  local fsessions = function(n)
    local msessions = require("mini.sessions")
    local items = vim.tbl_keys(msessions.detected)

    local fitems = {}
    for indx, el in ipairs(items) do
      local els = vim.split(el, " ")
      local name = els[1]
      local path = els[2] and "  -> " .. els[2] or ""
      path = path:gsub("%%", "/")
      table.insert(fitems, {
        name = name .. path,
        action = function()
          msessions.read(els)
        end,
        section = "Sessions",
      })
      if indx == n then
        break
      end
    end
    return fitems
    -- return {
    --   { name = 'Item #1 from function', action = [[echo 'Item #1']], section = 'From function' },
    --   { name = 'Placeholder (always inactive) item', action = '', section = 'From function' },
    -- }
    -- local msessions = require('mini.sessions')
    -- local items = vim.tbl_keys(msessions.detected)
    -- local fitems = {}
    -- for indx, el in ipairs(items) do
    --   local els = vim.split(el, ' ')
    --   local name = els[1]
    --   local path = els[2] and '  -> ' .. els[2] or ''
    --   path = path:gsub('%%', '/')
    --   table.insert(fitems, {name = name .. path, action = function()msessions.read(els)end, sction =  'Sessions'})
    --   if indx == n then
    --     break
    --   end
    -- end
    -- return fitems
  end
  local starter = require("mini.starter")
  starter.setup({
    --     header =
    -- "⠀⠀⣀⣤⣤⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣦⣤⣤⣀⠀".. "\n"..
    -- "⢠⣾⠟⢋⣉⡉⠛⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠛⢉⣉⠙⠻⣷".. "\n"..
    -- "⣾⡏⠀⠛⠛⠛⠃⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠁⠘⠛⠛⠛⠀⢹".. "\n"..
    -- "⢻⣷⡈⠻⠿⠿⠃⣰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣆⠘⠿⠿⠟⢀⣾".. "\n"..
    -- "⠀⠙⠿⣶⣤⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣤⣶⠿⠋".. "\n"..
    -- "⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⡿⠋⣿⣿⣿⠙⢿⣿⣿⣿⠀⠀⠀⠀⠀⠀".. "\n"..
    -- "⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⠃⠀⢻⣿⡟⠀⠘⣿⣿⣿⠀⠀⠀⠀⠀⠀".. "\n"..
    -- ""
    -- ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░░▒▓█▓▒░      ░▒▓██████▓▒░
    -- ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░
    -- ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓████████▓▒░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░
    -- ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░
    --  ░▒▓█████████████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓████████▓▒░▒▓██████▓▒░
    header = "PERFECTO",
    footer = "---",
    evaluate_single = true,
    items = {
      -- starter.sections.telescope(),
      starter.sections.builtin_actions(),
      --
      fsessions(4),
      {
        { name = "Files", action = [[Pick files]], section = "CMD" },
        { name = "Old files", action = [[Pick oldfiles]], section = "CMD" },
        -- {name="Old files", action = [[Pick oldfiles]], section="CMD"},
      },
      -- starter.sections.pick(),

      -- starter.sections.recent_files(6, false),
      -- starter.sections.recent_files(6, true),
      --     -- Use this if you set up 'mini.sessions'
      -- starter.sections.sessions(5, true),
    },
    content_hooks = {
      -- starter.gen_hook.padding(2,2),
      starter.gen_hook.adding_bullet(),
      -- starter.gen_hook.adding_bullet('┃ '),
      -- starter.gen_hook.indexing('all', { 'Builtin actions' }),
      -- starter.gen_hook.adding_bullet('├ ', true),
      starter.gen_hook.aligning("center", "center"),
      -- starter.gen_hook.indexing('all', { 'Builtin actions' }),
      -- starter.gen_hook.padding(3, 2),

      -- starter.gen_hook.adding_bullet('» '),
      -- starter.gen_hook.adding_bullet('░ '),
      -- -- ░ ▒ ▓ » · ■ ├ ╠
      -- starter.gen_hook.aligning('center', 'center'),
      -- starter.gen_hook.adding_bullet(),
      -- starter.gen_hook.aligning('center', 'center'),
    },
  })
end
