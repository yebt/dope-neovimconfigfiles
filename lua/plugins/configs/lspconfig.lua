return function()
  local lspconfig = require('lspconfig')
  local mason = require('mason')
  local masonlsp = require('mason-lspconfig')

  mason.setup({})
  masonlsp.setup({
    ensure_installed = { 'lua_ls', 'pyright' },
    automatic_installation = false,
    handlers = {},
  })

  local default_settings = {}

  -- Borders
  -- Specify how the border looks like
  local border = {
    { '┌', 'FloatBorder' },
    { '─', 'FloatBorder' },
    { '┐', 'FloatBorder' },
    { '│', 'FloatBorder' },
    { '┘', 'FloatBorder' },
    { '─', 'FloatBorder' },
    { '└', 'FloatBorder' },
    { '│', 'FloatBorder' },
  }

  -- Add the border on hover and on signature help popup window
  local handlers = {
    ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
    ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
    -- ['window/showDocument'] = vim.lsp.with(vim.lsp.util.show_document, { border = "rounded" }),
  }

  default_settings.handlers = handlers

  -- pass completins capabilities
  -- default_settings.capabilities = require("cmp_nvim_lsp").default_capabilities()
  -- default_settings.capabilities =vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), require("epo").register_cap())
  -- require('lspconfig').pyright.setup({})
  masonlsp.setup_handlers({
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- default handler (optional)
      require('lspconfig')[server_name].setup(default_settings)
    end,

    ['lua_ls'] = function()
      local opts = vim.tbl_extend('force', default_settings, {
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' },
            },
          },
        },
      })
      lspconfig.lua_ls.setup(opts)
    end,
  })
end
