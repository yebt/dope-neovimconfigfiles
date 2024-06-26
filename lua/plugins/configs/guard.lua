return function()
  local ft = require('guard.filetype')

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
end
