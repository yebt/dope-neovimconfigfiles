return {

  -- better practices
  {
    'm4xshen/hardtime.nvim',
    -- lazy=false,
    event = 'FileType',
    dependencies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
    opts = {
      disabled_filetypes = {
        'NvimTree',
        'TelescopePrompt',
        'aerial',
        'alpha',
        'checkhealth',
        'dapui*',
        'Diffview*',
        'Dressing*',
        'help',
        'httpResult',
        'lazy',
        'lspinfo',
        'Neogit*',
        'mason',
        'neotest%-summary',
        'minifiles',
        'neo%-tree*',
        'netrw',
        'noice',
        'notify',
        'prompt',
        'qf',
        'query',
        'oil',
        'undotree',
        'trouble',
        'Trouble',
        'fugitive',
        'saga*', -- lspsaga
      },
      hints = {
        ['[dcyvV][ia][%(%)]'] = {
          message = function(keys)
            return 'Use ' .. keys:sub(1, 2) .. 'b instead of ' .. keys
          end,
          length = 3,
        },
        ['[dcyvV][ia][%{%}]'] = {
          message = function(keys)
            return 'Use ' .. keys:sub(1, 2) .. 'B instead of ' .. keys
          end,
          length = 3,
        },
      },
    },
  },
}
