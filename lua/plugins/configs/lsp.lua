return function()
  local mason = require('mason')
  local lspconfig = require('lspconfig')
  local masonlsp = require('mason-lspconfig')

  -- -- Add additional capabilities supported by nvim-cmp
  -- local capabilities = require('cmp_nvim_lsp').default_capabilities()

  mason.setup({
    log_level = vim.log.levels.INFO,
    ui = {
      icons = {
        -- package_installed = '✓',
        -- package_pending = '➜',
        -- package_uninstalled = '✗',
      },
    },
  })

  masonlsp.setup({
    -- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "lua_ls" }
    -- This setting has no relation with the `automatic_installation` setting.
    ---@type string[]
    ensure_installed = {},

    -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
    -- This setting has no relation with the `ensure_installed` setting.
    -- Can either be:
    --   - false: Servers are not automatically installed.
    --   - true: All servers set up via lspconfig are automatically installed.
    --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
    --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
    ---@type boolean
    automatic_installation = false,

    -- See `:h mason-lspconfig.setup_handlers()`
    ---@type table<string, fun(server_name: string)>?
    -- handlers = nil,
  })

  masonlsp.setup_handlers({
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- default handler (optional)
      require('lspconfig')[server_name].setup({})
    end,
    -- Next, you can provide a dedicated handler for specific servers.
    -- For example, a handler override for the `rust_analyzer`:
    -- ['rust_analyzer'] = function()
    --   require('rust-tools').setup({})
    -- end,

    ['lua_ls'] = function()
      local lspconfig = require('lspconfig')
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' },
            },
          },
        },
      })
    end,
  })
  -- vim.notify('load the lsp powers')
end
