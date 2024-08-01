return function()
  -- local opts = {}
  --- Signs
  -- Error = " ",
  -- Warn  = " ",
  -- Hint  = " ",
  -- Info  = " ",
  local opts = {
    signs = {
      [vim.diagnostic.severity.ERROR] = 'E',
      [vim.diagnostic.severity.WARN] = 'W',
      [vim.diagnostic.severity.HINT] = 'H',
      [vim.diagnostic.severity.INFO] = 'I',
    },
    inlay_hints = {
      exclude = {},
    },
  }

  ---------------------------------------------------------------------------------------------
  local _supports_method = {}

  function on_supports_method(method, fn)
    _supports_method[method] = _supports_method[method] or setmetatable({}, { __mode = 'k' })
    return vim.api.nvim_create_autocmd('User', {
      pattern = 'LspSupportsMethod',
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        local buffer = args.data.buffer ---@type number
        if client and method == args.data.method then
          return fn(client, buffer)
        end
      end,
    })
  end

  function on_attach(on_attach, name)
    return vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local buffer = args.buf ---@type number
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and (not name or client.name == name) then
          return on_attach(client, buffer)
        end
      end,
    })
  end

  function _check_methods(client, buffer)
    -- don't trigger on invalid buffers
    if not vim.api.nvim_buf_is_valid(buffer) then
      return
    end
    -- don't trigger on non-listed buffers
    if not vim.bo[buffer].buflisted then
      return
    end
    -- don't trigger on nofile buffers
    if vim.bo[buffer].buftype == 'nofile' then
      return
    end
    for method, clients in pairs(_supports_method) do
      clients[client] = clients[client] or {}
      if not clients[client][buffer] then
        if client.supports_method and client.supports_method(method, { bufnr = buffer }) then
          clients[client][buffer] = true
          vim.api.nvim_exec_autocmds('User', {
            pattern = 'LspSupportsMethod',
            data = { client_id = client.id, buffer = buffer, method = method },
          })
        end
      end
    end
  end

  function on_dynamic_capability(fn, opts)
    return vim.api.nvim_create_autocmd('User', {
      pattern = 'LspDynamicCapability',
      group = opts and opts.group or nil,
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        local buffer = args.data.buffer ---@type number
        if client then
          return fn(client, buffer)
        end
      end,
    })
  end

  function on_dynamic_capability(fn, opts)
    return vim.api.nvim_create_autocmd('User', {
      pattern = 'LspDynamicCapability',
      group = opts and opts.group or nil,
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        local buffer = args.data.buffer ---@type number
        if client then
          return fn(client, buffer)
        end
      end,
    })
  end

  function lsp_setup()
    --- LSP setup
    local register_capability = vim.lsp.handlers['client/registerCapability']
    vim.lsp.handlers['client/registerCapability'] = function(err, res, ctx)
      ---@diagnostic disable-next-line: no-unknown
      local ret = register_capability(err, res, ctx)
      local client = vim.lsp.get_client_by_id(ctx.client_id)
      if client then
        for buffer in pairs(client.attached_buffers) do
          vim.api.nvim_exec_autocmds('User', {
            pattern = 'LspDynamicCapability',
            data = { client_id = client.id, buffer = buffer },
          })
        end
      end
      return ret
    end
    on_attach(_check_methods)
    on_dynamic_capability(_check_methods)
  end
  ---------------------------------------------------------------------------------------------

  --- Setup formatter
  --- Setup Keymaps
  on_attach(function(client, buffer)
    require('inside.lspkymaps').on_attach(client, buffer)
  end)

  --- LSP Setup
  lsp_setup()

  --- Dinamic capabilities
  on_dynamic_capability(require('inside.lsp.keymaps').on_attach)

  --- Words
  require('inside.lsp.word').setup({
    enabled = true,
  }, on_supports_method)

  --- Diagnostic signs
  for severity, icon in pairs(opts.signs) do
    local name = vim.diagnostic.severity[severity]:lower():gsub('^%l', string.upper)
    name = 'DiagnosticSign' .. name
    vim.fn.sign_define(name, { text = icon, texthl = name, numhl = '' })
  end

  --- Inlay Hints
  on_supports_method('textDocument/inlayHint', function(client, buffer)
    if
      vim.api.nvim_buf_is_valid(buffer)
      and vim.bo[buffer].buftype == ''
      and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buffer].filetype)
    then
      vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
    end
  end)

  --- Code Lens
  on_supports_method('textDocument/codeLens', function(client, buffer)
    vim.lsp.codelens.refresh()
    vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
      buffer = buffer,
      callback = vim.lsp.codelens.refresh,
    })
  end)

  --- Diagnostics
  vim.diagnostic.config({
    underline = true,
    virtual_text = true,
    update_in_insert = false,
    suffix = '●',
    border = 'rounded',
  })
end
