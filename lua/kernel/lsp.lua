local map = vim.keymap.set
local vlspb = vim.lsp.buf
local au = vim.api.nvim_create_autocmd
local mapopts = function(desc)
  return { noremap = true, silent = true, desc = desc }
end

-- Diagnostic configs
vim.diagnostic.config({
  underline = true,
  virtual_text = true,
  signs = true,
  float = {
    -- border = 'solid',
    focused = false,
    style = 'minimal',
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
  update_in_insert = false,
  severity_sort = false,
})

--
local toggle_lsp_client = function()
  local buf = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = buf })
  if not vim.tbl_isempty(clients) then
    vim.cmd('LspStop')
  else
    vim.cmd('LspStart')
  end
end
map('n', '<leader>lt', toggle_lsp_client, mapopts('LSP Toggle'))
-- vim.lsp.buf.execute_command

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    local client_has = function(method)
      return client.supports_method(method)
    end
    -- if client.supports_method('textDocument/implementation') then
    --   -- Create a keymap for vim.lsp.buf.implementation
    -- end

    --# callHierarchy/incomingCalls
    if client_has('callHierarchy/incomingCalls') then
      map('n', '<leader>lic', function(...)
        vlspb.incominmg_calls(...)
      end, mapopts('LSP Incoming Calls'))
    end
    --# callHierarchy/outgoingCalls
    if client_has('callHierarchy/outgoingCalls') then
      map('n', '<leader>loc', function(...)
        vlspb.outgoing_calls(...)
      end, mapopts('LSP Outcoming Calls'))
    end
    --# textDocument/codeAction
    if client_has('textDocument/codeAction') then
      map('n', '<leader>lca', function(...)
        -- TODO: handler the code actions https://neovim.io/doc/user/lsp.html#vim.lsp.buf.code_action()
        -- TODO: lsopsaga code action
        vlspb.code_action(...)
      end, mapopts('LSP code action'))
    end

    --# textDocument/completion
    if client_has('textDocument/completion') then
    end

    --# textDocument/declaration*
    -- if client_has('textDocument/declaration*') then
    map('n', 'gD', vlspb.declaration, mapopts('LSP go to declaration'))
    -- end

    --# textDocument/codeLens
    if client_has('textDocument/codeLens') then
      map('n', '<leader>lclc', vim.lsp.codelens.clear, mapopts('LSP code lens clear'))
      map('n', '<leader>lcld', vim.lsp.codelens.display, mapopts('LSP code lens display'))
      map('n', '<leader>lclp', function()
        print(vim.inspect(vim.lsp.codelens.get()))
      end, mapopts('LSP code lens list'))
      au({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
        buffer = 0,
        callback = function()
          vim.lsp.codelens.refresh({ bufnr = 0 })
        end,
      })
      map('n', '<leader>lclr', vim.lsp.codelens.run, mapopts('LSP code lens run'))
    end

    --# textDocument/definition
    map('n', 'gt', vlspb.definition, mapopts('LSP go to definition'))

    --# textDocument/diagnostic
    map('n', '<leader>e', function()
      vim.diagnostic.open_float()
      -- TODO: Put trouble here
    end, mapopts('LSP open diagnostics'))
    map('n', '[d', vim.diagnostic.goto_prev, mapopts('LSP Prev Diagnostic'))
    map('n', ']d', vim.diagnostic.goto_next, mapopts('LSP Next Diagnostic'))
    -- Todo put touble here
    map('n', '<leader>lq', vim.diagnostic.setloclist, mapopts('LSP Set loc list'))

    --# textDocument/documentHighlight
    if client_has('textDocument/documentHighlight') then
      au({ 'CursorHold' }, {
        buffer = 0,
        callback = vlspb.document_highlight,
      })
      au({ 'CursorHoldI' }, {
        buffer = 0,
        callback = vlspb.document_highlight,
      })
      au({ 'CursorMoved' }, {
        buffer = 0,
        callback = vlspb.clear_references,
      })

      -- TODO: Define
      -- hl-LspReferenceText
      -- hl-LspReferenceRead
      -- hl-LspReferenceWrite
    end

    --# textDocument/documentSymbol
    if client_has('textDocument/documentSymbol') then
      map('n', '<leader>lds', function(...)
        vlspb.document_symbol(...)
        -- TODO: add trouble
      end, mapopts('LSP document symbols'))
    end

    --# textDocument/formatting
    -- textDocument/rangeFormatting
    -- textDocument/rangesFormatting
    --overwrite_format2
    map('n', '<leader>lf', function()
      -- Format all
      -- vim.lsp.buf.format({ async = true })
      -- Select
      require('utils.lsp').overwrite_format2()
    end, mapopts('LSP Format'))
    --# textDocument/hover
    -- TODO: some plugin
    map('n', 'K', vlspb.hover, mapopts('LSP Show hover'))

    --# textDocument/implementation*
    map('n', 'gD', vlspb.implementation, mapopts('LSP go to declaration'))

    -- textDocument/inlayHint
    if client_has('textDocument/inlayHint') then
      -- Enable
      vim.lsp.inlay_hint.enable(true)
      -- make toggler
      map('n', '<leader>liht', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end, mapopts('LSP Toggle Inlay Hint'))

      map('n', '<leader>liha', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end, mapopts('LSP apply inlay hint'))
    end
    -- textDocument/prepareTypeHierarchy
    if client_has('textDocument/prepareTypeHierarchy') then
      map('n', 'gr', vlspb.typehierarchy, mapopts('LSP go to prepare Type Hierarchy'))
    end

    -- textDocument/publishDiagnostics

    -- textDocument/references
    if client_has('textDocument/references') then
      map('n', 'gr', vlspb.references, mapopts('LSP go to reference'))
    end

    --# textDocument/rename
    if client_has('textDocument/rename') then
      map('n', '<leader>rn', vlspb.rename, mapopts('Lsp Rename'))
      map('n', '<F2>', vlspb.rename, mapopts('Lsp Rename'))
    end

    --# textDocument/semanticTokens/full
    --# textDocument/semanticTokens/full/delta
    --# textDocument/signatureHelp
    if client_has('textDocument/signatureHelp') then
      map('n', '<C-k>', vlspb.signature_help, mapopts('Lsp Signature help'))
    end

    --# textDocument/typeDefinition*
    map('n', 'gT', vlspb.type_definition, mapopts('LSP go to type definition'))

    --# typeHierarchy/subtypes
    --# typeHierarchy/supertypes
    --# window/logMessage
    --# window/showMessage
    --# window/showDocument
    --# window/showMessageRequest
    --# workspace/applyEdit
    --# workspace/configuration
    --# workspace/executeCommand
    --# workspace/inlayHint/refresh
    --# workspace/symbol
    if client_has('workspace/symbol') then
      map('n', '<space>lws', vlspb.workspace_symbol, mapopts('LSP Workspace Symbols'))
    end

    --# workspace/workspaceFolders
    map('n', '<space>lwa', vlspb.add_workspace_folder, mapopts('LSP Workspace add folder '))
    map('n', '<space>lwr', vlspb.remove_workspace_folder, mapopts('LSP Workspace remove folder'))
    map('n', '<space>lwl', function()
      print(vim.inspect(vlspb.list_workspace_folders()))
    end, mapopts('LSP Workspace list folders'))
  end,

  --
})
