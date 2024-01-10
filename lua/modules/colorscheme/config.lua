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

function config.nvimgelion()
  vim.cmd.colorscheme('nvimgelion')
end

function config.everblush()
  require('everblush').setup({

    -- Default options
    override = {},
    transparent_background = false,
    nvim_tree = {
      contrast = false,
    },
    -- Configuration examples
    -- Override the default highlights using Everblush or other colors
    override = {
      -- Normal = { fg = '#ffffff', bg = 'comment' },
    },
    -- Set transparent background
    -- transparent_background = true,
    -- Set contrast for nvim-tree highlights
    nvim_tree = {
      contrast = true,
    },
  })
  vim.cmd.colorscheme('everblush')
end

function config.aquarium()
  vim.cmd.colorscheme('aquarium')
end

function config.catppuccin()
  require('catppuccin').setup({
    flavour = 'mocha', -- latte, frappe, macchiato, mocha
    background = { -- :h background
      light = 'latte',
      dark = 'mocha',
    },
    transparent_background = false, -- disables setting the background color.
    show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
    term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
    dim_inactive = {
      enabled = false, -- dims the background color of inactive window
      shade = 'dark',
      percentage = 0.15, -- percentage of the shade to apply to the inactive window
    },
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    no_underline = false, -- Force no underline
    styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
      comments = { 'italic' }, -- Change the style of comments
      conditionals = { 'italic' },
      loops = {},
      functions = {},
      keywords = {},
      strings = {},
      variables = {},
      numbers = {},
      booleans = {},
      properties = {},
      types = {},
      operators = {},
    },
    color_overrides = {
      all = {
        text = '#ffffff',
      },
      latte = {
        base = '#ff0000',
        mantle = '#242424',
        crust = '#474747',
      },
      frappe = {},
      macchiato = {},
      mocha = {},
    },
    custom_highlights = {},
    integrations = {
      cmp = true,
      gitsigns = true,
      nvimtree = true,
      treesitter = true,
      notify = false,
      mini = {
        enabled = true,
        indentscope_color = '',
      },
      -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
  })

  -- setup must be called before loading
  vim.cmd.colorscheme('catppuccin')
end

function config.vitesse()
  require('vitesse').setup({
    comment_italics = true,
    transparent_background = false,
    transparent_float_background = false, -- aka pum(popup menu) background
    reverse_visual = true,
    dim_nc = true,
    cmp_cmdline_disable_search_highlight_group = false, -- disable search highlight group for cmp item
    -- if `transparent_float_background` false, make telescope border color same as float background
    telescope_border_follow_float_background = false,
    -- similar to above, but for lspsaga
    lspsaga_border_follow_float_background = false,
    -- diagnostic virtual text background, like error lens
    diagnostic_virtual_text_background = false,

    -- override the `lua/vitesse/palette.lua`, go to file see fields
    colors = {},
    themes = {},
  })
  vim.cmd.colorscheme('vitesse')
end

function config.tokyonight()
  require('tokyonight').setup({
    -- your configuration comes here
    -- or leave it empty to use the default settings
    style = 'night', -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
    light_style = 'day', -- The theme is used when the background is set to light
    transparent = false, -- Enable this to disable setting the background color
    terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
    styles = {
      -- Style to be applied to different syntax groups
      -- Value is any valid attr-list value for `:help nvim_set_hl`
      comments = { italic = true },
      keywords = { italic = true },
      functions = { bold = true },
      variables = {},
      -- Background styles. Can be "dark", "transparent" or "normal"
      sidebars = 'dark', -- style for sidebars, see below
      floats = 'dark', -- style for floating windows
    },
    sidebars = { 'qf', 'help' }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
    day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
    hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
    dim_inactive = true, -- dims inactive windows
    lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

    --- You can override specific color groups to use other groups or a hex color
    --- function will be called with a ColorScheme table
    ---@param colors ColorScheme
    on_colors = function(colors) end,

    --- You can override specific highlights to use other groups or a hex color
    --- function will be called with a Highlights and ColorScheme table
    ---@param highlights Highlights
    ---@param colors ColorScheme
    on_highlights = function(highlights, colors) end,
  })
  vim.cmd.colorscheme('tokyonight')
end
return config
