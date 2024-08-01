return function()
  local cmp = require('cmp')

  local cmp_icons = {
    Text = ' ',
    Method = ' ',
    Function = '󰊕 ',
    Constructor = ' ',
    Field = ' ',
    Variable = ' ',
    Class = ' ',
    Interface = ' ',
    Module = ' ',
    Property = ' ',
    Unit = ' ',
    Value = ' ',
    rnum = ' ',
    Keyword = ' ',
    Snippet = ' ',
    Color = ' ',
    File = ' ',
    Reference = ' ',
    Folder = ' ',
    EnumMember = ' ',
    Constant = '󰏿 ',
    Struct = ' ',
    Event = '⚡',
    Operator = ' ',
    TypeParameter = ' ',
  }

  local codicons = {
    Text = '',
    Method = '',
    Function = '',
    Constructor = '',
    Field = '',
    Variable = '',
    Class = '',
    Interface = '',
    Module = '',
    Property = '',
    Unit = '',
    Value = '',
    Enum = '',
    Keyword = '',
    Snippet = '',
    Color = '',
    File = '',
    Reference = '',
    Folder = '',
    EnumMember = '',
    Constant = '',
    Struct = '',
    Event = '',
    Operator = '',
    TypeParameter = '',
  }

  local codicons_fixed = {
    Text = '',
    Method = '󰆧',
    Function = '󰊕',
    Constructor = '',
    Field = '󰜢',
    Variable = '󰀫',
    Class = '󰠱',
    Interface = '',
    Module = '',
    Property = '󰜢',
    Unit = '󰑭',
    Value = '󰎠',
    Enum = '',
    Keyword = '󰌋',
    Snippet = '',
    Color = '󰏘',
    File = '󰈙',
    Reference = '󰈇',
    Folder = '󰉋',
    EnumMember = '',
    Constant = '󰏿',
    Struct = '󰙅',
    Event = '',
    Operator = '󰆕',
    TypeParameter = '',
  }

  local text_icons = {
    Text = 'Txt',
    Method = 'Mtd',
    Function = 'Fnc',
    Constructor = 'Cnr',
    Field = 'Fld',
    Variable = 'Var',
    Class = 'Cls',
    Interface = 'Int',
    Module = 'Mod',
    Property = 'Prp',
    Unit = 'Unt',
    Value = 'Val',
    enum = 'Enu',
    Keyword = 'Kyw',
    Snippet = 'Snp',
    Color = 'Clr',
    File = 'Fil',
    Reference = 'Ref',
    Folder = 'Dir',
    EnumMember = 'EnM',
    Constant = 'Cns',
    Struct = 'Str',
    Event = 'Evn',
    Operator = 'Opr',
    TypeParameter = 'TPm',
  }

  cmp.setup({
    -- enabled = true,
    debounce = 50,
    throttle = 200,
    preselect = cmp.PreselectMode.None,
    view = {
      docs = {
        auto_opts = true,
        follow_cursor = true,
      }
    },
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        -- vim.fn['vsnip#anonymous'](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      -- ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ['<C-y>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ['<CR>'] = cmp.mapping.confirm(), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      -- { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
      {
        name = 'path',
        option = {
          -- Options go into this table
          trailing_slash = true,
          label_trailing_slash = true,
        },
      },
    }),

    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
      -- completion = {
      --   winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,Search:None',
      --   col_offset = -3,
      --   side_padding = 0,
      -- },
    },

    formatting = {
      --- Mode 2
      -- fields = { 'kind', 'abbr', 'menu' },
      format = function(entry, vim_item)
        if entry.source.name == 'nvim_lsp' then
          -- vim_item.menu = '(' .. text_icons[vim_item.kind] or vim_item.kind .. ')'
          vim_item.menu = '(' .. vim_item.kind .. ')'
        else
          vim_item.menu = ({
            buffer = '[Buf]',
            -- nvim_lsp = '[LSP]',
            nvim_lua = '[Lua]',
            latex_symbols = '[LTX]',
            path = '[PTH]',
          })[entry.source.name]
        end

        local icon, hl_group
        if vim.tbl_contains({ 'path' }, entry.source.name) and vim_item.kind ~= 'Folder' then
          -- icon, hl_group = require('nvim-web-devicons').get_icon(entry:get_completion_item().label)
          icon, hl_group = require('nvim-web-devicons').get_icon(vim_item.abbr)
        else
          icon = codicons[vim_item.kind]
        end

        vim_item.kind = ' ' .. (icon or 'µ') .. ' '
        if hl_group then
          vim_item.kind_hl_group = hl_group
        end --

        return vim_item
      end,

      --- MODE 1
      -- format = function(entry, vim_item)
      --   vim_item.menu = ({

      --     buffer = '[Buf]',
      --     nvim_lsp = '[LSP]',
      --     nvim_lua = '[Lua]',
      --     latex_symbols = '[LTX]',
      --     path = '[PTH]'
      --   })[entry.source.name]
      --   if vim.tbl_contains({ 'path' }, entry.source.name) then
      --     local icon, hl_group = require('nvim-web-devicons').get_icon(entry:get_completion_item().label)
      --     if icon then
      --       vim_item.kind = icon
      --       vim_item.kind_hl_group = hl_group
      --       return vim_item
      --     end
      --   end
      --
      --   return require('lspkind').cmp_format({
      --     -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
      --     mode = 'symbol',
      --     -- default: 'default'
      --     preset = 'codicons',
      --     ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
      --     show_labelDetails = true, -- show labelDetails in menu. Disabled by default
      --     -- with_text = true,
      --   })(entry, vim_item)
      -- end,
    },
  })

  -- Customization for Pmenu

  -- vim.api.nvim_set_hl(0, 'PmenuSel', { bg = '#282C34', fg = 'NONE' })
  -- vim.api.nvim_set_hl(0, 'Pmenu', { fg = '#C5CDD9', bg = '#22252A' })

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
end
