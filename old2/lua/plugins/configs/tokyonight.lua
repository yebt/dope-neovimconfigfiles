return function()
  local tokyonight = require("tokyonight")

  tokyonight.setup({
    -- your configuration comes here
    -- or leave it empty to use the default settings
    style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
    light_style = "day", -- The theme is used when the background is set to light
    transparent = false, -- Enable this to disable setting the background color
    terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
    styles = {
      -- Style to be applied to different syntax groups
      -- Value is any valid attr-list value for `:help nvim_set_hl`
      comments = { italic = true },
      keywords = { italic = true },
      functions = {},
      variables = {},
      -- Background styles. Can be "dark", "transparent" or "normal"
      sidebars = "dark", -- style for sidebars, see below
      floats = "dark", -- style for floating windows
    },
    sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
    day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
    hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
    dim_inactive = false, -- dims inactive windows
    lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold

    --- You can override specific color groups to use other groups or a hex color
    --- function will be called with a ColorScheme table
    ---@param colors ColorScheme
    -- on_colors = function(colors)
    --   colors.bg = '#1a1b26'
    --   colors.bg_dark = '#16161e'
    --   colors.bg_float = '#16161e'
    --   colors.bg_highlight = '#292e42'
    --   colors.bg_popup = '#16161e'
    --   colors.bg_search = '#3d59a1'
    --   colors.bg_sidebar = '#16161e'
    --   colors.bg_statusline = '#16161e'
    --   colors.bg_visual = '#283457'
    -- end,
    on_colors = function(colors)
      -- colors
    end,

    --- You can override specific highlights to use other groups or a hex color
    --- function will be called with a Highlights and ColorScheme table
    ---@param highlights Highlights
    ---@param colors ColorScheme
    on_highlights = function(highlights, colors)
      highlights.FoldColumn = {
        bg = "#1a1b26",
        fg = "#565f89",
      }
      -- highlights.GitSignsAdd = { bg = colors.git.add } -- diff mode: Added line |diff.txt|
      -- highlights.GitSignsChange = { bg = colors.git.change } -- diff mode: Changed line |diff.txt|
      -- highlights.GitSignsDelete = { bg = colors.git.delete } -- diff mode: Deleted line |diff.txt|

      -- highlights.Pmenu = {
      --   bg = '#16161e',
      --   fg = '#c0caf5',
      -- }
      -- highlights.PmenuExtra = {
      --   fg = colors.green1,
      --   bg = colors.red,
      -- }
      -- highlights.PmenuSel = {
      --   fg = colors.magenta,
      --   bg = colors.yellow,
      -- }
      -- highlights.PmenuKind = {
      --   fg = colors.red,
      -- }
      -- highlights.PmenuKindSel = {
      --   bg = colors.magenta,
      -- }
      -- highlights.PmenuExtraSel = {
      --   bg = colors.teal,
      -- }
      -- highlights.PmenuSbar = {
      --   bg = colors.blue,
      -- }
      -- highlights.PmenuThumb = {
      --   bg = colors.red,
      -- }
    end,
  }) -- to make a Papercolor with greath support
end
