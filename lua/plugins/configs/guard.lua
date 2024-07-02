return function()
  local ft = require('guard.filetype')

  --- Markdownlint-cli
  -- try to add the linter and the formatter
  --- Formatter
  ft('markdown'):fmt({
    fn = function(buf, range)
      if vim.fn.has('nvim-0.10') ~= 1 then
        vim.notify('[guard-manual]: mardownlint uses vim.system introduced in nvim 0.10', 4)
        return
      end

      vim.system({ 'echo', 'hello' }, {}, function(obj)
        vim.notify(vim.inspect(obj), 3)
      end)
      -- local handler = vim.system({
      --   'markdownlint',
      --   '--fix',
      --   vim.api.nvim_buf_get_name(buf),
      -- }, {
      --   on_exit = function(obj)
      --     vim.notify(vim.inspect(obj))
      --   end,
      -- })
    end,
    -- cmd = 'markdownlint',
    -- args = {
    --   '--fix',
    -- },
    -- fname = true,
    -- parse = function(...)
    --   return "uwu"
    -- end
  })

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

  _G.guard_status = function()
    -- display icon if auto-format is enabled for current buffer
    local au = vim.api.nvim_get_autocmds({
      group = 'Guard',
      buffer = 0,
    })
    if vim.bo.ft and #au ~= 0 then
      return is_formatting and '' or ''
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
