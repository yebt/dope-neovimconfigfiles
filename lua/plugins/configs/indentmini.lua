return function()
  require('indentmini').setup({
    -- ╎ │ ▏
    char = '▏',
    exclude = { 'markdown' },
    minlevel = 1,
  })
  -- vim.api.nvim_set_hl(0, 'CmpItemKindTypeParameter', { fg = '#D8EEEB', bg = '#58B5A8' })
  -- Colors are applied automatically based on user-defined highlight groups.
  -- There is no default value.
  -- vim.cmd.highlight('IndentLine guifg=#123456')
  -- Current indent line highlight
  -- vim.cmd.highlight('IndentLineCurrent guifg=#123456')
end
