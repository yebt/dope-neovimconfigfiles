return function()
  local minidiff = require('mini.diff')

  minidiff.setup(
    -- No need to copy this inside `setup()`. Will be used automatically.
    {
      -- Options for how hunks are visualized
      view = {
        -- Visualization style. Possible values are 'sign' and 'number'.
        -- Default: 'number' if line numbers are enabled, 'sign' otherwise.
        -- style = vim.go.number and 'number' or 'sign',
        style = 'sign',

        -- Signs used for hunks with 'sign' view
        signs = { add = '+', change = '~', delete = '-' },

        -- Priority of used visualization extmarks
        priority = 199,
      },

      -- Source for how reference text is computed/updated/etc
      -- Uses content from Git index by default
      source = nil,

      -- Delays (in ms) defining asynchronous processes
      delay = {
        -- How much to wait before update following every text change
        text_change = 200,
      },

      -- Module mappings. Use `''` (empty string) to disable one.
      mappings = {
        -- Apply hunks inside a visual/operator region
        apply = 'gh',

        -- Reset hunks inside a visual/operator region
        reset = 'gH',

        -- Hunk range textobject to be used inside operator
        -- Works also in Visual mode if mapping differs from apply and reset
        textobject = 'gh',

        -- Go to hunk range in corresponding direction
        goto_first = '[H',
        goto_prev = '[h',
        goto_next = ']h',
        goto_last = ']H',
      },

      -- Various options
      options = {
        -- Diff algorithm. See `:h vim.diff()`.
        algorithm = 'histogram',

        -- Whether to use "indent heuristic". See `:h vim.diff()`.
        indent_heuristic = true,

        -- The amount of second-stage diff to align lines (in Neovim>=0.9)
        linematch = 60,

        -- Whether to wrap around edges during hunk navigation
        wrap_goto = false
      },
    }
  )

  -- highlight
  --
  local htoinvert = {
    'MiniDiffSignAdd',
    'MiniDiffSignChange',
    'MiniDiffSignDelete',
  }

  local nrml = vim.api.nvim_get_hl(0, { name = 'Normal' })
  for _, v in ipairs(htoinvert) do
    local tmph = vim.api.nvim_get_hl(0, { name = v })
    vim.api.nvim_set_hl(0, v, { fg = nrml.bg , bg = tmph.fg })
  end
  -- local mdsa = vim.api.nvim_get_hl(0, { name = 'MiniDiffSignAdd' })
  -- local mdsc = vim.api.nvim_get_hl(0, { name = 'MiniDiffSignChange' })
  -- local mdsd = vim.api.nvim_get_hl(0, { name = 'MiniDiffSignDelete' })
  -- vim.notify(vim.inspect(mdsd))

  -- vim.api.nvim_set_hl(0, 'Pmenu', { fg = '#C5CDD9', bg = '#22252A' })

  -- local format_summary = function(data)
  --   local summary = vim.b[data.buf].minidiff_summary
  --   local t = {}
  --   if summary.add > 0 then
  --     table.insert(t, '+' .. summary.add)
  --   end
  --   if summary.change > 0 then
  --     table.insert(t, '~' .. summary.change)
  --   end
  --   if summary.delete > 0 then
  --     table.insert(t, '-' .. summary.delete)
  --   end
  --   vim.b[data.buf].minidiff_summary_string = table.concat(t, ' ')
  -- end
  -- local au_opts = { pattern = 'MiniDiffUpdated', callback = format_summary }
  -- vim.api.nvim_create_autocmd('User', au_opts)
end
