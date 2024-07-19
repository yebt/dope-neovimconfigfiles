local M = {}
M.overwrite_format2 = function(options)
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
    vim.notify("[LSP] Format request failed, no matching language servers.", vim.log.levels.WARN)
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

return M
