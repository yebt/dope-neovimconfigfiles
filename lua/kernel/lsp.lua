vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    -- if client.supports_method('textDocument/implementation') then
    --   -- Create a keymap for vim.lsp.buf.implementation
    -- end

    -- callHierarchy/incomingCalls
    -- callHierarchy/outgoingCalls
    -- textDocument/codeAction
    -- textDocument/completion
    -- textDocument/declaration*
    -- textDocument/definition
    -- textDocument/diagnostic
    -- textDocument/documentHighlight
    -- textDocument/documentSymbol
    -- textDocument/formatting
    -- textDocument/hover
    -- textDocument/implementation*
    -- textDocument/inlayHint
    -- textDocument/prepareTypeHierarchy
    -- textDocument/publishDiagnostics
    -- textDocument/rangeFormatting
    -- textDocument/rangesFormatting
    -- textDocument/references
    -- textDocument/rename
    -- textDocument/semanticTokens/full
    -- textDocument/semanticTokens/full/delta
    -- textDocument/signatureHelp
    -- textDocument/typeDefinition*
    -- typeHierarchy/subtypes
    -- typeHierarchy/supertypes
    -- window/logMessage
    -- window/showMessage
    -- window/showDocument
    -- window/showMessageRequest
    -- workspace/applyEdit
    -- workspace/configuration
    -- workspace/executeCommand
    -- workspace/inlayHint/refresh
    -- workspace/symbol
    -- workspace/workspaceFolders
  end,
})
