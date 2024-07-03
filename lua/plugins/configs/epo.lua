return function()
  -- Preload autopairs to load premaps
  local minipairs = require('mini.pairs')

  -- use default settings
  require('epo').setup({
    -- fuzzy match
    -- fuzzy = true,
    -- increase this value can aviod trigger complete when delete character.
    -- debounce = 50,
    debounce = 1000,
    -- when completion confrim auto show a signature help floating window.
    signature = true,
    -- border for lsp signature popup, :h nvim_open_win
    signature_border = 'rounded',
    -- lsp kind formatting, k is kind string "Field", "Struct", "Keyword" etc.
    kind_format = function(k)
      -- vim.notify(vim.inspect(k))
      return k
    end,
  })

  ---------------- MAPS -------------------------
  -- Expand snippet
  vim.keymap.set({ 'i', 's' }, '<TAB>', function()
    if vim.snippet.active({ direction = 1 }) then
      return '<cmd>lua vim.snippet.jump(1)<cr>'
    else
      return '<TAB>'
    end

    -- if vim.fn.pumvisible() == 1 then
    --   return '<C-n>'
    --   -- elseif vim.snippet.jumpable(1) then
    -- elseif vim.snippet.active({ direction = 1 }) then
    --   return '<cmd>lua vim.snippet.jump(1)<cr>'
    -- else
    --   return '<TAB>'
    -- end
  end, { expr = true })

  -- jump -1
  vim.keymap.set({ 'i', 's' }, '<S-TAB>', function()
    if vim.snippet.active({ direction = -1 }) then
      return '<cmd>lua vim.snippet.jump(-1)<cr>'
    else
      return '<TAB>'
    end
    -- if vim.fn.pumvisible() == 1 then
    --   return '<C-p>'
    --   -- elseif vim.snippet.jumpable(-1) then
    -- elseif vim.snippet.active({ direction = -1 }) then
    --   return '<cmd>lua vim.snippet.jump(-1)<CR>'
    -- else
    --   return '<S-TAB>'
    -- end
  end, { expr = true })

  -- cancel completion
  vim.keymap.set('i', '<C-e>', function()
    if vim.fn.pumvisible() == 1 then
      require('epo').disable_trigger()
    end
    return '<C-e>'
  end, { expr = true })

  -- completion esc to dont use the completion
  -- vim.keymap.set('i', '<esc>', function()
  --   if vim.fn.pumvisible() == 1 then
  --     require('epo').disable_trigger()
  --     return '<c-e>'
  --   end
  --   return '<esc>'
  -- end, { expr = true, noremap = true })

  -- For using enter as completion, may conflict with some autopair plugin
  vim.keymap.set('i', '<cr>', function()
    if vim.fn.pumvisible() == 1 then
      return '<C-y>'
    end
    -- return '<cr>'
    return minipairs.cr()
  end, { expr = true, noremap = true })

  ----------

  -- LSP settings (for overriding per client)
  -- local handlers =  {
  --   ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = border}),
  --   ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = border }),
  -- }
  --
  -- -- Do not forget to use the on_attach function
  -- require 'lspconfig'.myserver.setup { handlers=handlers }
  --
  -- -- To instead override globally
  -- local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
  -- function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  --   opts = opts or {}
  --   opts.border = opts.border or border
  --   return orig_util_open_floating_preview(contents, syntax, opts, ...)
  -- end

  -- the default completetopt set by epo
  -- vim.opt.completeopt = 'menu,menuone,noselect,noinsert,popup'
end
