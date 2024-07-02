return function()
  local minicompletion = require('mini.completion')

  local opts = {
    -- Delay (debounce type, in ms) between certain Neovim event and action.
    -- This can be used to (virtually) disable certain automatic actions by
    -- setting very high delay time (like 10^7).
    delay = { completion = 100, info = 100, signature = 50 },

    -- Configuration for action windows:
    -- - `height` and `width` are maximum dimensions.
    -- - `border` defines border (as in `nvim_open_win()`).
    window = {
      info = { height = 25, width = 80, border = 'none' },
      signature = { height = 25, width = 80, border = 'none' },
    },

    -- Way of how module does LSP completion
    lsp_completion = {
      -- `source_func` should be one of 'completefunc' or 'omnifunc'.
      source_func = 'completefunc',

      -- `auto_setup` should be boolean indicating if LSP completion is set up
      -- on every `BufEnter` event.
      auto_setup = true,

      -- `process_items` should be a function which takes LSP
      -- 'textDocument/completion' response items and word to complete. Its
      -- output should be a table of the same nature as input items. The most
      -- common use-cases are custom filtering and sorting. You can use
      -- default `process_items` as `MiniCompletion.default_process_items()`.
      -- process_items = --<function: filters out snippets; sorts by LSP specs>,
      process_items = function(items,base)
        -- vim.notify(vim.inspect(items))
        local kitems =vim.tbl_map(function(val)
          -- kind
          -- insertText
          if val.kind == 15 then
            -- val.insertText = vim.snippet.expand(val.insertText)
            -- vim.notify(vim.inspect(vim.snippet.expand('${TM_FILENAME/(.*)\\..+$/$1/}')))
            -- val.insertText = ""
            vim.notify(vim.inspect(val))
          end
          return val
        end,items)
        -- table.sort(kitems, function(a, b) return (a.sortText or a.label) < (b.sortText or b.label) end)
        return items
      end
    },

    -- Fallback action. It will always be run in Insert mode. To use Neovim's
    -- built-in completion (see `:h ins-completion`), supply its mapping as
    -- string. Example: to use 'whole lines' completion, supply '<C-x><C-l>'.
    -- fallback_action = --<function: like `<C-n>` completion>,

    -- Module mappings. Use `''` (empty string) to disable one. Some of them
    -- might conflict with system mappings.
    mappings = {
      force_twostep = '<C-Space>', -- Force two-step completion
      force_fallback = '<A-Space>', -- Force fallback completion
    },

    -- Whether to set Vim's settings for better experience (modifies
    -- `shortmess` and `completeopt`)
    set_vim_settings = true
  }

  --
  minicompletion.setup(opts)
end
