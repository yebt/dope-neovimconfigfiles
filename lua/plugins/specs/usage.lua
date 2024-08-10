--- ----------------------------------------
--- Plugins for a better usage, but
--- not needed for coding
--- ----------------------------------------
local colorizer = 'nvim-highlight-colors' -- 'nvim-colorizer.nvim' 'nvim-highlight-colors'
function is_clrzr(plgn)
  return plgn.name == colorizer
end
return {
  --- Colors view
  {
    'NvChad/nvim-colorizer.lua',
    -- event = { 'VeryLazy' },
    cond = is_clrzr,
    cmd = {
      'ColorizerToggle',
    },
    keys = {
      { '<m-s-c>', ':ColorizerToggle<CR>', mode = { 'n', 'x' } },
    },
    opts = {
      -- enabled = false,
      filetypes = {
        '*',
        cmp_docs = { always_update = true },
        -- css = {}
      },
      user_default_options = { mode = 'background', tailwind = true },

      -- user_default_options = {
      --   RGB = true, -- #RGB hex codes
      --   RRGGBB = true, -- #RRGGBB hex codes
      --   names = true, -- "Name" codes like Blue or blue
      --   RRGGBBAA = false, -- #RRGGBBAA hex codes
      --   AARRGGBB = false, -- 0xAARRGGBB hex codes
      --   rgb_fn = false, -- CSS rgb() and rgba() functions
      --   hsl_fn = false, -- CSS hsl() and hsla() functions
      --   css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
      --   css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
      --   -- Available modes for `mode`: foreground, background,  virtualtext
      --   mode = 'background', -- Set the display mode.
      --   -- Available methods are false / true / "normal" / "lsp" / "both"
      --   -- True is same as normal
      --   tailwind = true, -- Enable tailwind colors
      --   -- parsers can contain values used in |user_default_options|
      --   sass = { enable = false, parsers = { 'css' } }, -- Enable sass colors
      --   virtualtext = '■',
      --   -- update color values even if buffer is not focused
      --   -- example use: cmp_menu, cmp_docs
      --   always_update = true,
      -- },
      -- -- all the sub-options of filetypes apply to buftypes
      -- buftypes = {},
    },
  },

  --- Colors 2
  {
    'brenoprata10/nvim-highlight-colors',
    cond = is_clrzr,
    cmd = {
      'HighlightColors',
    },

    keys = {
      { '<m-s-c>', ':HighlightColors Toggle<CR>', mode = { 'n', 'x' } },
    },
    opts = {
      ---Render style
      ---@usage 'background'|'foreground'|'virtual'
      render = 'background',

      ---Set virtual symbol (requires render to be set to 'virtual')
      virtual_symbol = '■',

      ---Set virtual symbol suffix (defaults to '')
      virtual_symbol_prefix = '',

      ---Set virtual symbol suffix (defaults to ' ')
      virtual_symbol_suffix = ' ',

      ---Set virtual symbol position()
      ---@usage 'inline'|'eol'|'eow'
      ---inline mimics VS Code style
      ---eol stands for `end of column` - Recommended to set `virtual_symbol_suffix = ''` when used.
      ---eow stands for `end of word` - Recommended to set `virtual_symbol_prefix = ' ' and virtual_symbol_suffix = ''` when used.
      virtual_symbol_position = 'inline',

      ---Highlight hex colors, e.g. '#FFFFFF'
      enable_hex = true,

      ---Highlight short hex colors e.g. '#fff'
      enable_short_hex = true,

      ---Highlight rgb colors, e.g. 'rgb(0 0 0)'
      enable_rgb = true,

      ---Highlight hsl colors, e.g. 'hsl(150deg 30% 40%)'
      enable_hsl = true,

      ---Highlight CSS variables, e.g. 'var(--testing-color)'
      enable_var_usage = true,

      ---Highlight named colors, e.g. 'green'
      enable_named_colors = true,

      ---Highlight tailwind colors, e.g. 'bg-blue-500'
      enable_tailwind = true,

      ---Set custom colors
      ---Label must be properly escaped with '%' to adhere to `string.gmatch`
      --- :help string.gmatch
      custom_colors = {
        { label = '%-%-theme%-primary%-color', color = '#0f1219' },
        { label = '%-%-theme%-secondary%-color', color = '#5a5d64' },
      },

      -- Exclude filetypes or buftypes from highlighting e.g. 'exclude_buftypes = {'text'}'
      exclude_filetypes = {},
      exclude_buftypes = {},
    },
  },

  --- Make a better markdown view
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    event = 'VeryLazy',
    cmd = {
      'RenderMarkdown',
    },
  },
}
