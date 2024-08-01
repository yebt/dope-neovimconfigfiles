-- Here for colorchemes
return {
  --- Porcelain
  {
    'nvimdev/porcelain.nvim',
  },

  --- Vague
  {
    'vague2k/vague.nvim',
  },

  --- Nightfly
  {
    'bluz71/vim-nightfly-colors',
  },

  --- Kanagawa
  {
    'rebelot/kanagawa.nvim',
    opts = {
      compile = true, -- enable compiling the colorscheme
      undercurl = true, -- enable undercurls
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = false, -- do not set background color
      dimInactive = true, -- dim inactive window `:h hl-NormalNC`
      terminalColors = true, -- define vim.g.terminal_color_{0,17}
      colors = { -- add/modify theme and palette colors
        palette = {},
        theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
      },
      -- overrides = function(colors) -- add/modify highlights
      --   return {}
      -- end,
      overrides = function(colors)
        local theme = colors.theme
        return {
          Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
          PmenuSel = { fg = 'NONE', bg = theme.ui.bg_p2 },
          PmenuSbar = { bg = theme.ui.bg_m1 },
          PmenuThumb = { bg = theme.ui.bg_p2 },

          -- -- Colors are applied automatically based on user-defined highlight groups.
          -- -- There is no default value.
          -- vim.cmd.highlight('IndentLine guifg=#123456')
          -- -- Current indent line highlight
          -- vim.cmd.highlight('IndentLineCurrent guifg=#123456')

          -- vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { fg = '#7E8294', bg = 'NONE', strikethrough = true })
          -- vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { fg = '#82AAFF', bg = 'NONE', bold = true })
          -- vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { fg = '#82AAFF', bg = 'NONE', bold = true })
          -- vim.api.nvim_set_hl(0, 'CmpItemMenu', { fg = '#C792EA', bg = 'NONE', italic = true })
          --
          -- vim.api.nvim_set_hl(0, 'CmpItemKindField', { fg = '#EED8DA' })
          -- vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { fg = '#EED8DA' })
          -- vim.api.nvim_set_hl(0, 'CmpItemKindEvent', { fg = '#EED8DA' })
          --
          -- vim.api.nvim_set_hl(0, 'CmpItemKindText', { fg = '#C3E88D' })
          -- vim.api.nvim_set_hl(0, 'CmpItemKindEnum', { fg = '#C3E88D' })
          -- vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { fg = '#C3E88D' })
          --
          -- vim.api.nvim_set_hl(0, 'CmpItemKindConstant', { fg = '#FFE082' })
          -- vim.api.nvim_set_hl(0, 'CmpItemKindConstructor', { fg = '#FFE082' })
          -- vim.api.nvim_set_hl(0, 'CmpItemKindReference', { fg = '#FFE082' })
          --
          -- vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { fg = '#EADFF0' })
          -- vim.api.nvim_set_hl(0, 'CmpItemKindStruct', { fg = '#EADFF0' })
          -- vim.api.nvim_set_hl(0, 'CmpItemKindClass', { fg = '#EADFF0' })
          -- vim.api.nvim_set_hl(0, 'CmpItemKindModule', { fg = '#EADFF0' })
          -- vim.api.nvim_set_hl(0, 'CmpItemKindOperator', { fg = '#EADFF0' })
          --
          -- vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { fg = '#C5CDD9' })
          -- vim.api.nvim_set_hl(0, 'CmpItemKindFile', { fg = '#C5CDD9' })
          --
          -- vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { fg = '#F5EBD9' })
          -- vim.api.nvim_set_hl(0, 'CmpItemKindSnippet', { fg = '#F5EBD9' })
          -- vim.api.nvim_set_hl(0, 'CmpItemKindFolder', { fg = '#F5EBD9' })
          --
          -- vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { fg = '#DDE5F5' })
          -- vim.api.nvim_set_hl(0, 'CmpItemKindValue', { fg = '#DDE5F5' })
          -- vim.api.nvim_set_hl(0, 'CmpItemKindEnumMember', { fg = '#DDE5F5' })
          --
          -- vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { fg = '#D8EEEB' })
          -- vim.api.nvim_set_hl(0, 'CmpItemKindColor', { fg = '#D8EEEB' })
          -- vim.api.nvim_set_hl(0, 'CmpItemKindTypeParameter', { fg = '#D8EEEB' })
        }
      end,
      theme = 'wave', -- Load "wave" theme when 'background' option is not set
      background = { -- map the value of 'background' option to a theme
        dark = 'wave', -- try "dragon" !
        light = 'lotus',
      },
    },
  },

  --- Catppucin
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    opts = {
      flavour = 'mocha', -- latte, frappe, macchiato, mocha
      background = { -- :h background
        light = 'latte',
        dark = 'mocha',
      },
      transparent_background = false, -- disables setting the background color.
      show_end_of_buffer = true, -- shows the '~' characters after the end of buffers
      term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
      dim_inactive = {
        enabled = true, -- dims the background color of inactive window
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
        functions = { 'bold' },
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
        -- miscs = {}, -- Uncomment to turn off hard-coded styles
      },
      color_overrides = {},
      custom_highlights = {},
      default_integrations = true,
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
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { 'italic' },
            hints = { 'italic' },
            warnings = { 'italic' },
            information = { 'italic' },
            ok = { 'italic' },
          },
          underlines = {
            errors = { 'underline' },
            hints = { 'underline' },
            warnings = { 'underline' },
            information = { 'underline' },
            ok = { 'underline' },
          },
          inlay_hints = {
            background = true,
          },
        },
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
      },
    },
  },

  --- Night owl
  {
    'oxfist/night-owl.nvim',
  },
}
