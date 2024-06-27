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

  local starter = require('mini.starter')
  starter.setup({
    header = '',
    footer = '',
    evaluate_single = true,
    items = {
      -- starter.sections.telescope(),
      starter.sections.builtin_actions(),

      starter.sections.recent_files(6, false),
      starter.sections.recent_files(6, true),
      --     -- Use this if you set up 'mini.sessions'
      starter.sections.sessions(5, true),
    },
    content_hooks = {
      starter.gen_hook.adding_bullet(),
      starter.gen_hook.aligning('center', 'center'),
      starter.gen_hook.indexing('all', { 'Builtin actions' }),
      starter.gen_hook.padding(3, 2),

      -- starter.gen_hook.adding_bullet('» '),
      -- starter.gen_hook.adding_bullet('░ '),
      -- -- ░ ▒ ▓ » · ■ ├ ╠
      -- starter.gen_hook.aligning('center', 'center'),
      -- starter.gen_hook.adding_bullet(),
      -- starter.gen_hook.aligning('center', 'center'),
    },
  })
end
