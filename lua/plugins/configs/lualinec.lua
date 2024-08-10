return function()
  require('lualine').setup({
    options = {
      icons_enabled = true,
      -- theme = 'horizon',
      -- theme = 'horizon',
      -- theme = 'tokyonight',
      -- component_separators = { left = '', right = ''},
      -- section_separators = { left = '', right = ''},
      section_separators = '',
      component_separators = '',

      disabled_filetypes = {
        statusline = { 'fzf' },
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      globalstatus = false,
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      },
    },
    sections = {
      lualine_a = { {
        'mode',
        fmt = function(str)
          return str:sub(1, 1)
        end,
      } },
      lualine_b = { 'branch', 'diff', 'diagnostics' },
      lualine_c = { 'filename' },
      lualine_x = { 'encoding', 'fileformat', 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = { 'location' },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { 'filename' },
      lualine_x = { 'location' },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    -- winbar = {
    --   lualine_a = {},
    --   lualine_b = {},
    --   lualine_c = { 'filename' },
    --   lualine_x = {},
    --   lualine_y = {},
    --   lualine_z = {},
    -- },
    -- inactive_winbar = {
    --   lualine_a = {},
    --   lualine_b = {},
    --   lualine_c = { 'filename' },
    --   lualine_x = {},
    --   lualine_y = {},
    --   lualine_z = {},
    -- },
    extensions = {},
  })
end
