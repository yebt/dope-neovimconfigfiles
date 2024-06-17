--- Load las opts
require('core.options')
--
-- Load lazy vim
require('core.lazy')

vim.api.nvim_create_autocmd({ 'User' }, {
  pattern = { 'VeryLazy' },
  callback = function(args)
    -- call internal calls
    local colorscheme = 'habamax'

    vim.cmd.colorscheme(colorscheme)

    local lazy_loads = {
      'keys',
      'events',
      'status',
    }

    for _, file in pairs(lazy_loads) do
      require('internal.' .. file)
    end

    -- aditional filetype event on verylazy
    vim.api.nvim_exec_autocmds('FileType', {})

    -- require("config.status")

    -- Aditional requires
    --require("locals.statusline")

    -- vim.schedule(function()
    --   --require("locals.statusline")
    --   --vim.api.nvim_exec_autocmds('User', { pattern = 'PostVeryLazy' })
    -- end)
  end,
})