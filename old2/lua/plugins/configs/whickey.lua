return function()
  vim.o.timeout = true
  vim.o.timeoutlen = 300
  require('which-key').setup({
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below

    icons = {
      breadcrumb = '»', -- symbol used in the command line area that shows your active key combo
      separator = '↯', -- symbol used between a key and it's label
      group = '+', -- symbol prepended to a group
    },
    layout = {
      height = { min = 4, max = 25 }, -- min and max height of the columns
      width = { min = 20, max = 50 }, -- min and max width of the columns
      spacing = 3, -- spacing between columns
      align = 'left', -- align columns left, center or right
    },
  })
end
