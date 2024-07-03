return function()
  local ft = require('guard.filetype')
  local linter = require('guard.lint')

  --- Markdownlint-cli
  -- try to add the linter and the formatter
  --- Formatter
  ft('markdown'):lint({
    fn = function(buf, range)
      vim.system(
        {
          'mardownlint',
          '--stdin',
        },
        {},
        vim.schedule_wrap(function(result)
          -- vim.notify(vim.inspect(result))
          if result.code ~= 0 then
            vim.notify(result.stderr, vim.log.levels.ERROR)
            return
          end
          -- reload changes
          vim.cmd([[silent e]])
        end)
      )
    end,
  })
  -- :fmt({
  --   fn = function(buf, range)
  --     if vim.fn.has('nvim-0.10') ~= 1 then
  --       vim.notify('[guard-manual]: mardownlint uses vim.system introduced in nvim 0.10', 4)
  --       return
  --     end
  --     vim.system(
  --       {
  --         'markdownlint',
  --         '--fix',
  --         vim.api.nvim_buf_get_name(buf),
  --       },
  --       {},
  --       vim.schedule_wrap(function(result)
  --         -- vim.notify(vim.inspect(result))
  --         if result.code ~= 0 then
  --           vim.notify(result.stderr, vim.log.levels.ERROR)
  --           return
  --         end
  --         -- reload changes
  --         vim.cmd([[silent e]])
  --       end)
  --     )
  --   end,
  -- })
  -- :lint({
  --   cmd = 'echo',
  --   args = { '-s' },
  --   -- stdin = true,
  --   fname = false,
  --   parse = function(result, bufnr)
  --     print(vim.inspect({ result, bufnr }))
  --     local diags = {}
  --     return diags
  --   end
  -- })

  -- Builting
  ft('lua'):fmt('lsp'):append('stylua')

  -- Assuming you have guard-collection
  -- ft('lang'):fmt('format-tool-1')
  --           :append('format-tool-2')
  --           :env(env_table)
  --           :lint('lint-tool-1')
  --           :extra(extra_args)

  -- Call setup() LAST!
  require('guard').setup({
    -- Choose to format on every write to a buffer
    fmt_on_save = true,
    -- Use lsp if no formatter was defined for this filetype
    lsp_as_default_formatter = false,
    -- By default, Guard writes the buffer on every format
    -- You can disable this by setting:
    -- save_on_fmt = false,
  })

  local is_formatting = false
  local group = require('guard.events').group

  _G.guard_status = function()
    -- display icon if auto-format is enabled for current buffer
    local au = vim.api.nvim_get_autocmds({
      group = 'Guard',
      buffer = 0,
    })
    if vim.bo.ft and #au ~= 0 then
      local bufau = vim.api.nvim_get_autocmds({ group = group, event = 'BufWritePre', buffer = 0 })
      if #bufau == 0 then
        return ''
        -- return '󰦞'
      end
      return is_formatting and '' or '󰞀'
      -- return is_formatting and '' or ''
    end
    return ''
  end
  -- sets a super simple statusline when entering a buffer
  vim.cmd('au BufEnter * lua vim.opt.stl = [[%f %m ]] .. guard_status()')
  -- update statusline on GuardFmt event
  vim.api.nvim_create_autocmd('User', {
    pattern = 'GuardFmt',
    callback = function(opt)
      -- receive data from opt.data
      is_formatting = opt.data.status == 'pending'
      -- vim.opt.stl = [[%f %m ]] .. guard_status()

      -- vim.opt.stl = (stl) .. guard_status()
    end,
  })
end
