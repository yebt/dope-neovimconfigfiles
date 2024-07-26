return function()
  vim.ui.select = function(...)
    vim.ui.select = minipick.ui_select
    return vim.ui.select(...)
  end
  -- Try to make
  -- Make the last buffer selector
end
