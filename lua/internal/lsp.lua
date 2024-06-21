-- -- some config for udpate tags on close tags with autotag
-- vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
--     vim.lsp.diagnostic.on_publish_diagnostics,
--     {
--         underline = true,
--         virtual_text = {
--             spacing = 5,
--             severity_limit = 'Warning',
--         },
--         update_in_insert = true,
--     }
-- )

--- Omnifunc: is set to vim.lsp.omnifunciton i_C-x_C-o completion funciton
--- tagfunction C-} C-w_], C-w_}
--- formatexpr: set vim.slp.formatexpr to use server:
---   - gq{motion} format with methods
---   - gw{motion} format and restore cursor position:
---     qwap: format the paragrap and continue where you were
---   - nnoremap Q gq

--- Maps
-- C-] tag commands
-- [d ]d: go to diagnostics
-- C-w_d: open diagnostic float

-- vim.lsp.set_log_level("debug") -- debug cause problems of perfomance
