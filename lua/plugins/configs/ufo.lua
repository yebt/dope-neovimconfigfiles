return function()
  local o = vim.o
  local mps = vim.keymap.set
  local ufo = require('ufo')

  -- Re settings
  o.foldcolumn = '1'
  o.foldlevel = 99
  o.foldlevelstart = 99
  o.foldenable = true

  -- Remaps
  mps('n', 'zR', ufo.openAllFolds, { desc = 'Open All Folds' })
  mps('n', 'zM', ufo.closeAllFolds, { desc = 'Close All Folds' })

  -- Function for format the fold

  local handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = (' 󰁂 %d '):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
      local chunkText = chunk[1]
      local chunkWidth = vim.fn.strdisplaywidth(chunkText)
      if targetWidth > curWidth + chunkWidth then
        table.insert(newVirtText, chunk)
      else
        chunkText = truncate(chunkText, targetWidth - curWidth)
        local hlGroup = chunk[2]
        table.insert(newVirtText, { chunkText, hlGroup })
        chunkWidth = vim.fn.strdisplaywidth(chunkText)
        -- str width returned from truncate() may less than 2nd argument, need padding
        if curWidth + chunkWidth < targetWidth then
          suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
        end
        break
      end
      curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, { suffix, 'MoreMsg' })
    return newVirtText
  end

  --
  local opts = {
    fold_virt_text_handler = handler,
    open_fold_hl_timeout = 150,
    close_fold_kinds_for_ft = {
      default = { 'imports', 'comment' },
      json = { 'array' },
      c = { 'comment', 'region' },
    },
    provider_selector = function(bnfnr, filetype, buftype)
      return { 'lsp', 'indent' }
    end,
  }
  ufo.setup(opts)
end
