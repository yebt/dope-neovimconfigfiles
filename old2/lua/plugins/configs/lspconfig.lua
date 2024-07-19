return function()
  local lspconfig = require("lspconfig")
  local mason = require("mason")
  local masonlsp = require("mason-lspconfig")
  local util = require("utils.functions")

  mason.setup({
    ui = {
      border = "rounded",
    },
  })

  masonlsp.setup({
    ensure_installed = { "lua_ls", "pyright" },
    automatic_installation = false,
    handlers = {},
  })

  local default_settings = {}

  -- Borders
  -- Specify how the border looks like
  local border = {
    { "┌", "FloatBorder" },
    { "─", "FloatBorder" },
    { "┐", "FloatBorder" },
    { "│", "FloatBorder" },
    { "┘", "FloatBorder" },
    { "─", "FloatBorder" },
    { "└", "FloatBorder" },
    { "│", "FloatBorder" },
  }

  -- Add the border on hover and on signature help popup window
  local handlers = {
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
    ["window/showDocument"] = vim.lsp.with(vim.lsp.util.show_document, { border = "rounded" }),
  }

  -- default_settings.handlers = handlers

  -- pass completins capabilities
  -- default_settings.capabilities = require("cmp_nvim_lsp").default_capabilities()
  if _G.kernel.opts.plugins.completion == "epo" and util.plugin_is_available("epo") then
    default_settings.capabilities =
      vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), require("epo").register_cap())
  end
  -- require('lspconfig').pyright.setup({})
  masonlsp.setup_handlers({
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- default handler (optional)
      require("lspconfig")[server_name].setup(default_settings)
    end,

    ["lua_ls"] = function()
      local opts = vim.tbl_extend("force", default_settings, {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })
      lspconfig.lua_ls.setup(opts)
    end,

    ["emmet_language_server"] = function()
      local opts = vim.tbl_extend("force", default_settings, {
        init_options = {
          ---@type table<string, string>
          includeLanguages = {},
          --- @type string[]
          excludeLanguages = {},
          --- @type string[]
          extensionsPath = {},
          --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
          preferences = {},
          --- @type boolean Defaults to `true`
          showAbbreviationSuggestions = true,
          --- @type "always" | "never" Defaults to `"always"`
          showExpandedAbbreviation = "always",
          --- @type boolean Defaults to `false`
          showSuggestionsAsSnippets = true,
          --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
          syntaxProfiles = {},
          --- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
          variables = {},
        },
      })
      lspconfig.emmet_language_server.setup(opts)
    end,
  })
end
