local config = {}

function config.kanagawa()
  -- Default options:
  require('kanagawa').setup({
    compile = true, -- enable compiling the colorscheme
    undercurl = true, -- enable undercurls
    commentStyle = { italic = true },
    functionStyle = { bold = true },
    keywordStyle = { italic = true },
    statementStyle = { bold = true },
    typeStyle = {},
    transparent = false, -- do not set background color
    dimInactive = true, -- dim inactive window `:h hl-NormalNC`
    terminalColors = true, -- define vim.g.terminal_color_{0,17}
    colors = { -- add/modify theme and palette colors
      palette = {},
      theme = {
        wave = {},
        lotus = {},
        dragon = {},
        all = {
          -- Remove gutter background
          ui = {
            bg_gutter = 'none',
          },
        },
      },
    },
    overrides = function(colors) -- add/modify highlights
      -- Borderless Telescope
      local theme = colors.theme

      return {
        -- Borderless Telescope
        TelescopeTitle = { fg = theme.ui.special, bold = true },
        TelescopePromptNormal = { bg = theme.ui.bg_p1 },
        TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
        TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
        TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
        TelescopePreviewNormal = { bg = theme.ui.bg_dim },
        TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
        -- Dark completion (popup) menu
        Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
        PmenuSel = { fg = 'NONE', bg = theme.ui.bg_p2 },
        PmenuSbar = { bg = theme.ui.bg_m1 },
        PmenuThumb = { bg = theme.ui.bg_p2 },
      }
    end,
    theme = 'dragon', -- Load "wave" theme when 'background' option is not set
    background = { -- map the value of 'background' option to a theme
      dark = 'dragon', -- try "dragon" !
      light = 'lotus',
    },
  })

  -- setup must be called before loading
  vim.cmd('colorscheme kanagawa')
end

function config.cyberdream()
  require('cyberdream').setup({
    -- Recommended - see "Configuring" below for more config options
    transparent = false,
    italic_comments = true,
    hide_fillchars = false,
    borderless_telescope = true,
  })
  vim.cmd('colorscheme cyberdream') -- set the colorscheme
end

function config.night_owl()
  vim.cmd.colorscheme('night-owl')
end

function config.monokai_nightasty()
  local opts = {
    dark_style_background = 'default', -- default, dark, transparent, #color
    light_style_background = 'default', -- default, dark, transparent, #color
    terminal_colors = true, -- Set the colors used when opening a `:terminal`
    color_headers = false, -- Enable header colors for each header level (h1, h2, etc.)
    hl_styles = {
      -- Style to be applied to different syntax groups. See `:help nvim_set_hl`
      comments = { italic = true },
      keywords = { italic = false },
      functions = {},
      variables = {},
      -- Background styles for sidebars (panels) and floating windows:
      floats = 'default', -- default, dark, transparent
      sidebars = 'default', -- default, dark, transparent
    },
    sidebars = { 'qf', 'help' }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`

    hide_inactive_statusline = false, -- Hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
    dim_inactive = false, -- dims inactive windows
    lualine_bold = true, -- Lualine headers will be bold or regular.
    lualine_style = 'default', -- "dark", "light" or "default" (Follows dark/light style)

    --- You can override specific color groups to use other groups or a hex color
    --- function will be called with a the theme ColorScheme table
    on_colors = function(colors) end,

    --- You can override specific highlights to use other groups or a hex color
    --- function will be called with the theme Highlights and ColorScheme tables
    on_highlights = function(highlights, colors) end,
  }
  require('monokai-nightasty').load(opts)

  vim.cmd.colorscheme('monokai-nightasty')
end

function config.ronny()
  vim.cmd.colorscheme('ronny')
  require('ronny').setup({
    display = {
      -- Enable original Monokai colors
      monokai_original = false,
      -- Highlight only LineNr (current line number) for cursorline
      -- option. This also enables cursorline (:set cursorline)
      only_CursorLineNr = true,
      -- Highlight LineNr for relativenumbers. This also enables
      -- relativenumbers option (:set relativenumbers)
      hi_relativenumber = false,
      -- Highlight unfocused windows when using :split or :vsplit
      hi_unfocus_window = false,
      -- Highlight formatted @text (e.g., italic, strong) in yellow
      -- in addition to font attributes to make the text more visible
      hi_formatted_text = true,
      -- Highlight comment in italics
      hi_comment_italic = true,
    },
  })
end

return config
