return function()
  local tkn = require('tokyonight')
  local util = require('tokyonight.util')

  tkn.setup({
    style = 'night', -- The theme comes in three styles, `storm`, a darker variant `night` and `day`
    light_style = 'day', -- The theme is used when the background is set to light
    transparent = false, -- Enable this to disable setting the background color
    terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
    styles = {
      -- Style to be applied to different syntax groups
      -- Value is any valid attr-list value for `:help nvim_set_hl`
      comments = { italic = true },
      keywords = { italic = true },
      functions = {},
      variables = {},
      -- Background styles. Can be "dark", "transparent" or "normal"
      sidebars = 'dark', -- style for sidebars, see below
      floats = 'dark', -- style for floating windows
    },
    day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
    dim_inactive = true, -- dims inactive windows
    lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

    --- You can override specific color groups to use other groups or a hex color
    --- function will be called with a ColorScheme table

    --
    -- M.colors = {
    --   black = "#121212",
    --   black1 = "#252525",
    --   black2 = "#393939",
    --   black3 = "#4d4d4d",
    --   white3 = "#c3c3c3",
    --   white2 = "#d7d7d7",
    --   white1 = "#ebebeb",
    --   white = "#ffffff",
    --
    --   ivory2 = "#eee8d5",
    --   purple6 = "#5a32a3",
    -- }
    --
    -- -- dark
    -- M.themes = {
    --   primary = "#4d9375",
    --
    --   foreground = "#c8c5b8",
    --   activeForeground = "#bebaab",
    --   secondaryForeground = "#83827d",
    --   ignored = "#383837",
    --   border = "#f0f0f0",
    --
    --   background = "#121212",
    --   activeBackground = "#181818",
    --
    --   lowBackground = "#222222",
    --   lowActiveBackground = "#292929",
    --   lowBorder = "#E7E5DB",
    --
    --   comment = "#5c6b5e",
    --   string = "#c98a7d",
    --   variable = "#bd976a",
    --   keyword = "#4d9375",
    --   number = "#4C9A91",
    --   boolean = "#4d9375",
    --   operator = "#cb7676",
    --   func = "#80a665",
    --   constant = "#c99076",
    --   class = "#6893BF",
    --   interface = "#5DA994",
    --   type = "#5da9a7",
    --   builtin = "#cb7676",
    --   property = "#b8a965",
    --   namespace = "#db889a",
    --   punctuation = "#666666",
    --   decorator = "#bd8f8f",
    --   regex = "#c4704f",
    --
    --   -- colors
    --   green = "#4d9375",
    --   cyan = "#5eaab5",
    --   blue = "#6394bf",
    --   red = "#cb7676",
    --   orange = "#d4976c",
    --   yellow = "#e6cc77",
    --   magenta = "#d9739f",
    -- }

    on_colors = function(colors)
      local black1 = '#121212' -- bg
      -- local black1 = '#121619' -- bg
      -- local black1 = '#121416' -- bg
      -- local black2 = '#252525' -- Floats and statusline
      local black2 = '#1c1c20' -- Floats and statusline
      -- local black2 = '#141418' -- Floats and statusline
      local black2_dark = '#0D0E0E' --- dim clors
      local black3 = '#292929' --- Cursorline
      -- local black4 = '#4d4d4d' --- Visual
      -- local visual = '#212625'
      -- local visual = '#272B2A'
      local visual = '#2D3639' --- Visual

      -- local comment = '#5c6b5e'
      local comment = '#546356'
      local signCol = '#83827d'
      -- local search =  util.darken( '#e6cc77',0.7, black1)
      local search = '#e6cc77'
      -- local primary = "#4d9375"
      local primary = '#5FB28E'
      -- local func = '#80a665'
      -- local func = '#7aa2f7'
      local func = '#A2D0A0'
      local magent = '#AE90E3'
      local teal = '#21ADCD'
      -- local war = '#D5975F'
      local war = '#FA830D'
      local yell = '#F5CC42'
      local compl = '#CAFE48'

      colors.bg = black1
      colors.bg_dark = black2_dark
      colors.bg_float = black2
      colors.bg_highlight = black3
      -- colors.bg_highlight = '#
      colors.bg_popup = black2
      -- colors.bg_search = search
      colors.bg_sidebar = black2
      colors.bg_statusline = black2
      colors.bg_visual = visual
      colors.black = '#15161e'
      -- colors.blue = '#7aa2f7' ---
      colors.blue = func
      colors.blue0 = search
      colors.blue1 = '#2ac3de'
      colors.blue2 = '#0db9d7'
      -- colors.blue5 = '#89ddff'
      colors.blue5 = '#E68383'
      colors.blue6 = '#b4f9f8'
      colors.blue7 = '#394b70'
      colors.border = '#15161e'
      colors.border_highlight = '#27a1b9'
      -- colors.comment = '#565f89'
      colors.comment = comment
      colors.cyan = '#7dcfff'
      colors.dark3 = '#545c7e'
      colors.dark5 = '#737aa2'
      colors.diff = {
        add = '#20303b',
        change = '#1f2231',
        delete = '#37222c',
        text = '#394b70',
      }
      colors.error = '#db4b4b'
      -- colors.fg = '#c0caf5'
      -- colors.fg = '#bd976a'
      -- colors.fg = '#D3BA9C'
      colors.fg = '#C8A983'
      colors.fg_dark = '#a9b1d6'
      colors.fg_float = '#c0caf5'
      -- colors.fg_gutter = '#3b4261'
      colors.fg_gutter = signCol
      colors.fg_sidebar = '#a9b1d6'
      colors.git = {
        add = '#449dab',
        change = '#6183bb',
        delete = '#914c54',
        ignore = '#545c7e',
      }
      -- colors.green = '#9ece6a'
      colors.green = compl
      colors.green1 = '#73DA91'
      colors.green2 = '#41a6b5'
      colors.hint = '#1abc9c'
      colors.info = '#0db9d7'
      -- colors.magenta = '#bb9af7'
      -- colors.magenta = '#cb7474'
      -- colors.magenta = '#DA8989'
      colors.magenta = magent
      colors.magenta2 = '#ff007c'
      colors.none = 'none'
      colors.orange = '#ff9e64'
      -- colors.purple = '#9d7cd8'
      colors.purple = primary
      colors.rainbow = { func, yell, compl, teal, magent, primary }
      colors.red = '#f7768e'
      colors.red1 = '#db4b4b'
      colors.teal = teal
      colors.terminal_black = '#414868'
      -- colors.todo = '#7aa2f7'
      colors.todo = func
      -- colors.warning = '#e0af68'
      colors.warning = war
      colors.yellow = yell
    end,

    --- you can override specific highlights to use other groups or a hex color
    --- function will be called with a Highlights and ColorScheme table
    ---@param highlights tokyonight.Highlights
    ---@param colors ColorScheme
    -- on_highlights = function(highlights, colors)
    on_highlights = function(hl, c)
      local prompt = '#2d3149'
      local lowComment = util.darken(c.comment, 0.2)
      local newLineNrBg = util.lighten(hl.Normal.bg, 0.98, '#ffffff')
      local newLineNrfg = util.darken(hl.LineNr.fg, 0.6, '#000000')
      local darkerBg = util.darken(hl.Normal.bg, 0.8, '#000000')
      local textfg = util.darken(
        -- util.lighten(hl.Normal.fg, 0.1, '#ffffff'),
        -- hl.Normal.fg,
        util.lighten(hl.Normal.fg, 0.4, '#ffffff'),
        0.75,
        hl.Normal.bg
      )

      --- Resalt numcolumn
      --- CursorLineNr   xxx cterm=bold gui=bold guifg=#ff9e64
      -- local k = util.darken( hl.Normal.bg, 0.1, "#111A1F")
      -- hl.CursorLineNr.bg =  util.darken( hl.Normal.bg, 0.7, "#000000")
      -- hl.LineNr.bg = util.lighten( hl.Normal.bg, 0.7, c.fg )
      -- hl.LineNr.bg = util.lighten( hl.Normal.bg, 0.1, c.fg )

      --- Resalt the column
      hl.LineNr = {
        bg = newLineNrBg,
        fg = newLineNrfg,
      }
      hl.LineNrAbove = 'LineNr'
      hl.LineNrBelow = 'LineNr'
      --- Darken fold column
      hl.FoldColumn = {
        bg = newLineNrBg,
        fg = lowComment,
      }
      --- Darken cursorline
      hl.CursorLineNr.bg = darkerBg
      hl.CursorLineFold = {
        fg = hl.FoldColumn.fg,
        bg = darkerBg,
      }
      hl.SignColumn.bg = newLineNrBg
      hl.CursorLineSign = {
        fg = hl.SignColumn.fg,
        bg = darkerBg,
      }
      -- hl.TabLineSel.reverse =  true
      hl.TabLineSel = {
        -- bg = hl.Normal.bg,
        -- fg = c.white,
        -- fg = c.green,
        -- bg = util.darken(c.blue, 0.2, '#000000'),
        -- bg = util.darken(hl.TabLineSel.bg, 0.3, '#000000'),
        -- bg =  c.gray
        -- fg = util.darken(c.fg, 0.4, '#fefefe'),
        -- bold = true,
        -- underline = true,
        bg = util.darken(hl.TabLineSel.bg, 0.8, '#000000'),
        -- fg = util.darken(hl.TabLineSel.bg, 0.4, c.yellow),
        fg = hl.TabLineSel.fg,
      }

      -- hl.Title =  {
      --   fg =  util.darken(c.orange, 0.9, '#000000'),
      --   bold = true
      -- }

      --       hl.TabWinNumSel = {
      --         fg = c.orange,
      --       }
      --       hl.TabNumSel = {
      --         fg = c.fg,
      --       }
      -- --
      --       vim.cmd([[
      -- hi TabLineSel term=bold cterm=bold ctermfg=16 ctermbg=229
      -- hi TabWinNumSel term=bold cterm=bold ctermfg=90 ctermbg=229
      -- hi TabNumSel term=bold cterm=bold ctermfg=16 ctermbg=229
      --
      -- hi TabLine term=underline ctermfg=16 ctermbg=145
      -- hi TabWinNum term=bold cterm=bold ctermfg=90 ctermbg=145
      -- hi TabNum term=bold cterm=bold ctermfg=16 ctermbg=145
      -- ]])

      --- Make a better string in md
      hl.String.fg = util.darken(c.green, 0.4, c.yellow)

      --- better text view
      hl.Normal.fg = textfg
      --- Invert the selection
      hl.Visual = {
        -- bg = util.lighten(c.info, 0.1, c.bg),
        bg = util.lighten(c.info, 0.08, c.bg),
        -- reverse = true,
      }

      -- TabLine        xxx guifg=#83827d guibg=#252525
      -- TabLineFill    xxx guibg=#15161e
      -- TabLineSel     xxx guifg=#15161e guibg=#a2d0a0

      -- hl.CursorLineNr.bg =  util.darken( "#111A1F", 0.6, "#000000")
      -- hl.black1

      --- TODO: make a better work with search
      --- TODO: fold
      -- Search         xxx guifg=#c8a983 guibg=#e6cc77
      hl.Search = {
        -- bg = util.darken( c.blue0, 0.4 , c.bg_search),
        bg = '#47CEFF',
        fg = c.black,
        italic = true,
      }

      ---cursor
      --- Cursor         xxx guifg=#4d4d4d guibg=#83827d
      hl.Cursor = {
        -- bg = '#4d4d4d',
        -- fg =  'NONE'
        -- fg = c.fg_gutter
      }

      hl.LazyButton = {
        bg = '#303030',
        -- bold = true,
      }
      hl.LazyButtonActive = {
        reverse = true,
      }
      --- Folded         xxx cterm=bold gui=bold guifg=#83827d guibg=#252525
      hl.Folded = {
        -- bg = "#131926",
        bg = '#192020',
        fg = c.fg_gutter,
        italic = true,
      }
    end,

    cache = true, -- When set to true, the theme will be cached for better performance

    ---@type table<string, boolean|{enabled:boolean}>
    --   plugins = {
    --     -- enable all plugins when not using lazy.nvim
    --     -- set to false to manually enable/disable plugins
    --     all = package.loaded.lazy == nil,
    --     -- uses your plugin manager to automatically enable needed plugins
    --     -- currently only lazy.nvim is supported
    --     auto = true,
    --     -- add any plugins here that you want to enable
    --     -- for all possible plugins, see:
    --     --   * https://github.com/folke/tokyonight.nvim/tree/main/lua/tokyonight/groups
    --     -- telescope = true,
    --   },
  })

  vim.cmd([[colorscheme tokyonight]])
end
