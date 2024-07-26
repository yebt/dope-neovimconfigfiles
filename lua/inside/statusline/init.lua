local co, api, iter = coroutine, vim.api, vim.iter
local p, hl = require('inside.statusline.provider'), api.nvim_set_hl

local function stl_format(name, val)
  return ('%%#ModeLine%s#%s%%*'):format(name, val)
end

local function default()
  local comps = {
    p.gitinfo(),
    p.git_branch(),
    ------------------
    -- p.mode(),
    -- p.encoding(),
    -- p.eol(),
    -- [[%{(&modified&&&readonly?'%*':(&modified?'**':(&readonly?'%%':'--')))}  ]],
    -- p.fileinfo(),
    -- '   %P   (L%l,C%c)  ',
    -- p.gitinfo(),
    -- ' %=',
    -- [[ %{!empty(bufname()) ? '(' : ''}]],
    -- '%{!empty(&filetype) ? toupper(strpart(&filetype, 0, 1)) . strpart(&filetype, 1) : toupper(strpart(&buftype, 0, 1)) . strpart(&buftype, 1)}',
    -- p.diagnostic(),
    -- [[%{!empty(bufname()) ? ')' : ''}]],
    -- p.progress(),
    -- p.lsp(),
    -- '%=%=',
  }
  local e, pieces = {}, {}
  iter(ipairs(comps))
    :map(function(key, item)
      if type(item) == 'string' then
        pieces[#pieces + 1] = item
      elseif type(item.stl) == 'string' then
        pieces[#pieces + 1] = stl_format(item.name, item.stl)
      else
        pieces[#pieces + 1] = item.default and stl_format(item.name, item.default) or ''
        for _, event in ipairs({ unpack(item.event or {}) }) do
          e[event] = e[event] or {}
          e[event][#e[event] + 1] = key
        end
      end
      if item.attr and item.name then
        hl(0, ('ModeLine%s'):format(item.name), item.attr)
      end
    end)
    :totable()
  return comps, e, pieces
end

local function render(comps, events, pieces)
  -- Corutine for render
  local stl_co_render = co.create(function()
    while true do
      local ok, r = pcall(function()
        vim.schedule(function()
          vim.opt.stl = table.concat(pieces)
        end)
      end)
      co.yield()
    end
  end)

  return co.create(function(args)
    while true do
      local event = args.event == 'User' and ('%s %s'):format(args.event, args.match) or args.event
      for _, idx in ipairs(events[event]) do
        if comps[idx].async then
          local child = comps[idx].stl()
          co.resume(child, pieces, idx, function()
            co.resume(stl_co_render)
          end)
        else
          pieces[idx] = stl_format(comps[idx].name, comps[idx].stl(args))
        end
      end
      vim.opt.stl = table.concat(pieces)
      args = co.yield()
    end
  end)
end

return {
  setup = function()
    local comps, events, pieces = default()
    local stl_render = render(comps, events, pieces)
    iter(vim.tbl_keys(events)):map(function(e)
      local tmp = e
      local pattern
      if e:find('User') then
        pattern = vim.split(e, '%s')[2]
        tmp = 'User'
      end
      api.nvim_create_autocmd(tmp, {
        pattern = pattern,
        callback = function(args)
          vim.schedule(function()
            local ok, res = co.resume(stl_render, args)
            if not ok then
              vim.notify('[ModeLine] render failed ' .. res, vim.log.levels.ERROR)
            end
          end)
        end,
      })
    end)
  end,
}
