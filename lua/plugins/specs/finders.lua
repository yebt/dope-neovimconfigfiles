-- HERE: Make most easy search
local selected_plugin = require('util.functions').selected_plugin

-- Select the finder plugin
function is_finder(plug)
  return selected_plugin('finder', plug.name)
end
-- Select  the plugin for the telescope
function telescope_prefomance(plug)
  return selected_plugin('telescope', plug.name)
end

return {

  -- FZF-LUA
  {
    'ibhagwan/fzf-lua',
    cmd = { 'FzfLua' },
    cond = is_finder,
    keys = {
      {
        '<C-p>',
        function()
          require('fzf-lua').files({
            -- previewer = false,
            -- winopts           = { height = 0.65, width = 0.60, },
            winopts = {
              height = 0.5, -- window height
              width = 0.60, -- window width
              row = 0.1,
              border = 'none',
              -- border = 'solid',
              -- border = { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" },
              -- border = { " ", "▔", " ", " ", " ", " ", " ", "▏" },
              backdrop = 70,

              preview = {
                default = 'bat',
                border = 'noborder',
                scrollbar = 'border',
              },
            },
            fzf_opts = {
              -- ['--layout'] = 'reverse-list',
            },
          })
        end,
      },
    },
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      { 'junegunn/fzf', build = './install --bin' },
    },
    config = require('plugins.configs.fzfluac'),
  },

  -- Telescope
  {
    'nvim-telescope/telescope.nvim',
    cond = is_finder,
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      --
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        name = 'fzf-native',
        cond = telescope_prefomance,
        build = 'make',
      },
    },
    cmd = {
      'Telescope',
    },
    keys = {
      {
        '<c-p>',
        function()
          require('telescope.builtin').find_files({
            results_title = 'Files',
            sorting_strategy = 'ascending', -- show results ascending
            layout_strategy = 'center',
            layout_config = {
              anchor = 'N', -- "", height"CENTER", "NW", "N", "NE", "E", "SE", "S", "SW", "W" The anchors
              mirror = true, -- Useful if the anchor is center, this put the preview below for strategy center
              preview_cutoff = 30, -- Preview should always show (unless previewer = false)
              width = function(_, max_columns, _)
                return math.min(max_columns, 80)
              end,

              height = function(_, _, max_lines)
                return math.min(max_lines, 15)
              end,
            },
            -- winblend =10,
            -- wrap_results = true,
            -- prompt_prefix = '＃ ',
            prompt_prefix = '? ',
            selection_caret = '＞ ',
            -- selection_caret = '- ',
            -- entry_prefix = '  ',
            multi_icon = '●',
            -- multi_icon = '＊',
            -- border = false,
            borderchars = {
              prompt = { '─', '│', ' ', '│', '╭', '╮', '│', '│' },
              results = { '─', '│', '─', '│', '├', '┤', '╯', '╰' },
              preview = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
            },
          })
        end,
      },
    },
    config = function()
      require('plugins.configs.telescopec')(telescope_prefomance)
    end,
  },

  -- Mini Pick
  {
    'echasnovski/mini.pick',
    version = false,
    name = 'mini.pick',
    cond = is_finder,
    cmd = { 'Pick' },
    keys = {
      {
        '<C-p>',
        function()
          MiniPick.builtin.files({ tool = 'rg' })
        end,
      },
      {
        '<leader>b',
        function()
          if MiniPick.registry.bufferlist then
            MiniPick.registry.bufferlist()
          end
        end,
      },
    },
    dependencies = {
      { 'echasnovski/mini.extra', version = false },
      ---
      {
        'echasnovski/mini.icons',
        version = false,
        cond = selected_plugin('pickicons', 'mini'),
        opts = {
          -- Icon style: 'glyph' or 'ascii'
          style = 'glyph',

          -- Customize per category. See `:h MiniIcons.config` for details.
          default = {},
          directory = {},
          extension = {},
          file = {},
          filetype = {},
          lsp = {},
          os = {},
        },
      },
      {
        'nvim-tree/nvim-web-devicons',
        cond = selected_plugin('pickicons', 'dev'),
      },
    },
    init = require('plugins.inits.minipicki'),
    config = require('plugins.configs.minipickc'),
  },

  -- FZF
  {
    'junegunn/fzf',
    build = './install --bin',
    cond = is_finder,
    cmd = {
      'Files',
      'GFiles',
      'Buffers',
      'Colors',
      'Ag',
      'Rg',
      'RG',
      'Lines',
      'BLines',
      'Tags',
      'BTags',
      'Changes',
      'Marks',
      'Jumps',
      'Windows',
      'Locate',
      'History',
      'History',
      'History',
      'Snippets',
      'Commits',
      'BCommits',
      'Commands',
      'Maps',
      'Helptags',
      'Filetypes',
    },
    dependencies = {
      { 'junegunn/fzf.vim' },
    },
  },
}
