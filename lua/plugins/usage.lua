return {
  -- Align
  {
    'godlygeek/tabular',
    cmd = {
      'Tab',
      'Tabularize',
    },
    ft = 'markdown',
  },

  -- Sessions
  {
    'echasnovski/mini.sessions',
    version = false,
    keys = {
      {
        '<leader>SS',
        function()
          MiniSessions.select()
        end,
        desc = 'Select a session',
      },
      {
        '<leader>SM',
        function()
          -- local session_name = ('%s%ssession'):format(vim.fn.stdpath('data'), '_')
          local cwd = vim.fn.getcwd()
          local basename = cwd:match('[^/]+$')
          local path = cwd:gsub('/', '%%')
          -- local session_name = vim.fn.getcwd():gsub(pattern, "%%")
          -- local session_name = basename .. " (" .. cwd .. ")"
          local session_name = basename .. ' (' .. path .. ')'
          -- vim.notify(vim.inspect(session_name))
          MiniSessions.write(session_name)
        end,
        desc = 'Make session',
      },
    },
    init = function()
      -- Make autosave session
      vim.api.nvim_create_autocmd('VimLeavePre', {
        group = vim.api.nvim_create_augroup('_mini_session_persistence', { clear = true }),
        callback = function()
          local buffers = vim.fn.getbufinfo({ buflisted = 1 })
          local cntrs = #buffers

          for _, buffer in ipairs(buffers) do
            if buffer.name == '' then
              cntrs = cntrs - 1
            end
          end

          if cntrs ~= 0 then
            local cwd = vim.fn.getcwd()
            local basename = cwd:match('[^/]+$')
            local path = cwd:gsub('/', '%%')
            local session_name = basename .. ' (' .. path .. ')'
            local session_opts = { verbose = false }
            if MiniSessions then
              MiniSessions.write(session_name)
              MiniSessions.write('latest') -- save the latest work
            end
          end
        end,
      })
    end,
    config = require('plugins.configs.minisessions'),
  },
}
