local api = vim.api
local util = vim.lsp.util
local kmset = vim.keymap.set
--

local function has_capability(capability, filter)
  for _, client in ipairs(vim.lsp.get_active_clients(filter)) do
    if client.supports_method(capability) then
      return true
    end
  end
  return false
end

--
local function add_buffer_autocmd(augroup, bufnr, autocmds)
  if not vim.tbl_islist(autocmds) then
    autocmds = { autocmds }
  end
  local cmds_found, cmds = pcall(vim.api.nvim_get_autocmds, { group = augroup, buffer = bufnr })
  if not cmds_found or vim.tbl_isempty(cmds) then
    vim.api.nvim_create_augroup(augroup, { clear = false })
    for _, autocmd in ipairs(autocmds) do
      local events = autocmd.events
      autocmd.events = nil
      autocmd.group = augroup
      autocmd.buffer = bufnr
      vim.api.nvim_create_autocmd(events, autocmd)
    end
  end
end

--
local function del_buffer_autocmd(augroup, bufnr)
  local cmds_found, cmds = pcall(vim.api.nvim_get_autocmds, { group = augroup, buffer = bufnr })
  if cmds_found then
    vim.tbl_map(function(cmd)
      vim.api.nvim_del_autocmd(cmd.id)
    end, cmds)
  end
end

--------------
--- FORMAT
---
local function overwrite_format2(options)
  options = options or {}
  local bufnr = options.bufnr or api.nvim_get_current_buf()
  local method = "textDocument/formatting"
  local clients = vim.lsp.get_active_clients({
    id = options.id,
    bufnr = bufnr,
    name = options.name,
    method = method,
  })

  if options.filter then
    clients = vim.tbl_filter(options.filter, clients)
  end
  -- filer if client.server_capabilities.documentFormattingProvider
  clients = vim.tbl_filter(function(client)
    return client.server_capabilities.documentFormattingProvider
  end, clients)

  if #clients == 0 then
    vim.notify("[LSP] Format request failed, no matching language servers.")
  end

  local copyClient = vim.deepcopy(clients)
  table.insert(copyClient, { name = "all" })
  table.insert(copyClient, { name = "Set default formatter" })

  --@private
  local function applyFormat(clientsi)
    if options.async then
      local do_format
      do_format = function(idx, client)
        if not client then
          return
        end
        -- local params = set_range(client, util.make_formatting_params(options.formatting_options))
        local params = util.make_formatting_params(options.formatting_options)
        client.request(method, params, function(...)
          local handler = client.handlers[method] or vim.lsp.handlers[method]
          handler(...)
          do_format(next(clientsi, idx))
        end, bufnr)
      end
      do_format(next(clientsi))
    else
      local timeout_ms = options.timeout_ms or 1000
      for _, client in pairs(clientsi) do
        local params = util.make_formatting_params(options.formatting_options)
        local result, err = client.request_sync(method, params, timeout_ms, bufnr)
        if result and result.result then
          util.apply_text_edits(result.result, bufnr, client.offset_encoding)
        end
        if err then
          vim.notify(string.format("[LSP][%s] %s", client.name, err), vim.log.levels.WARN)
        end
      end
    end
  end

  -- check if formatter is set
  if vim.g.defaultFormatClient then
    -- check if formatter is in list
    for _, client in pairs(clients) do
      if client.name == vim.g.defaultFormatClient then
        applyFormat({ client })
        return
      end
    end
    vim.notify("Default Formatter not found: " .. vim.g.defaultFormatClient)
  end

  if #clients > 1 then
    vim.ui.select(copyClient, {
      prompt = "Select a formatter:",
      format_item = function(item)
        return item.name
      end,
    }, function(choice)
      if not choice then
        vim.notify("No formatter selected")
      elseif choice.name == "all" then
        applyFormat(clients)
      elseif choice.name == "Set default formatter" then
        vim.ui.select(clients, {
          prompt = "Select a formatter:",
          format_item = function(item)
            return item.name
          end,
        }, function(choicei)
          if not choicei then
            vim.notify("No formatter selected")
          else
            vim.notify("Set default formatter:" .. choicei.name)
            vim.g.defaultFormatClient = choicei.name
            applyFormat({ choicei })
          end
        end)
      elseif choice then
        applyFormat({ choice })
      end
    end)
  else
    applyFormat(clients)
  end
end

--------------
--- SETTINGS
---
------------
vim.diagnostic.config({
  update_in_insert = true,
  underline = true,
  virtual_text = true,
  signs = true,
  float = {
    focused = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

--------------
--- GLOBAL MAPS
---
kmset("n", "<leader>e", vim.diagnostic.open_float, { silent = true, desc = "LSP: Open diagnostic float" })
kmset("n", "[d", vim.diagnostic.goto_prev, { silent = true, desc = "LSP: Go to previous diagnostic" })
kmset("n", "]d", vim.diagnostic.goto_next, { silent = true, desc = "LSP: Go to next diagnostic" })
-- kmset("n", "<leader>E", vim.diagnostic.setloclist, { silent = true, desc = "Set loclist" })
kmset("n", "<leader>E", ":TroubleToggle document_diagnostics<CR>", { silent = true, desc = "LSP: Set loclist" })

--------------
--- AUTOCMD
---
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("_UserLspAttachConfig", {}),
  callback = function(env)
    --- VARS
    local bufnr = env.buf
    local clientAttached = vim.lsp.get_client_by_id(env.data.client_id)
    --- CONFIGS
    if clientAttached.server_capabilities.completionProvider then
      vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
    end
    if clientAttached.server_capabilities.definitionProvider then
      vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
    end

    --- MAPS

    -- "textDocument/codeLens",
    -- "window/logMessage",
    -- "textDocument/completion",
    -- "textD ocument/declaration",
    -- "window/showMessageRequest",
    -- "textDocument/diagnostic",
    -- "wi ndow/workDoneProgress/create",
    -- "workspace/applyEdit",
    -- "textDocument/documentHighl ight",
    -- "workspace/configuration",
    -- "textDocument/documentSymbol",
    -- "hover",
    -- "textDo cument/implementation",
    -- "textDocument/inlayHint",
    -- "workspace/executeCommand",
    -- "wo rkspace/inlayHint/refresh",
    -- "workspace/semanticTokens/refresh",
    -- "workspace/symbol ",
    -- "textDocument/publishDiagnostics",
    -- "callHierarchy/outgoingCalls",
    -- "client/regi sterCapability",
    -- "client/unregisterCapability",
    -- "textDocument/references",
    -- "textD ocument/rename",
    -- "workspace/workspaceFolders",
    -- "signature_help",
    -- "textDocument/si gnatureHelp",
    -- "$/progress",
    -- "window/showDocument",
    -- "window/showMessage",
    -- "textDoc ument/rangeFormatting",
    -- "textDocument/formatting",
    -- "textDocument/hover",
    -- "textDoc ument/definition",
    -- "textDocument/typeDefinition",
    -- "callHierarchy/incomingCalls",
    --- Code Action
    vim.keymap.set(
      "n",
      "<leader>ca",
      ":Lspsaga code_action<CR>",
      { silent = true, buffer = bufnr, desc = "LSP: Code action" }
    )
  end,
})

-- vim.api.nvim_create_autocmd('LspNotify', {
--   callback = function(args)
--     local bufnr = args.buf
--     local client_id = args.data.client_id
--     local method = args.data.method
--     local params = args.data.params
--     -- do something with the notification
--     if method == 'textDocument/...' then
--       update_buffer(bufnr)
--     end
--   end,
-- })

-- vim.opt.cmdheight = 3

-- vim.api.nvim_create_autocmd('LspRequest', {
--   callback = function(args)
--     local bufnr = args.buf
--     local client_id = args.data.client_id
--     local request_id = args.data.request_id
--     local request = args.data.request
--     if request.type == 'pending' then
--       -- do something with pending requests
--       -- track_pending(client_id, bufnr, request_id, request)
--       -- vim.notify('Pending request: ' .. request.method)
--     elseif request.type == 'cancel' then
--       -- do something with pending cancel requests
--       -- track_canceling(client_id, bufnr, request_id, request)
--       -- vim.notify('Canceling request: ' .. request.method)
--     elseif request.type == 'complete' then
--       -- do something with finished requests. this pending
--       -- request entry is about to be removed since it is complete
--       -- track_finish(client_id, bufnr, request_id, request)
--       -- vim.notify('Finished request: ' .. request.method)
--     end
--     vim.notify(vim.inspect(vim.lsp.status()))
--   end,
-- })
