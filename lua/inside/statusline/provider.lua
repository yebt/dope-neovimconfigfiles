local api, uv, lsp, diagnostic, M = vim.api, vim.uv, vim.lsp, vim.diagnostic, {}
local fnamemodify = vim.fn.fnamemodify

-- Aux
local function system_exec(cmmnd, cr)
  if type(cmmnd) == 'string' then
    cmmnd = vim.split(cmmnd, ' ')
  end
  vim.system(cmmnd, { text = true }, function(result)
    coroutine.resume(cr, result)
  end)
end

local function get_stl_bg()
  return api.nvim_get_hl(0, { name = 'StatusLine' }).bg or 'back'
end

local stl_bg = get_stl_bg()
local function stl_attr(group)
  local color = api.nvim_get_hl(0, { name = group, link = false })
  return {
    bg = stl_bg,
    fg = color.fg,
  }
end

local function group_fmt(prefix, name, val)
  return ('%%#ModeLine%s%s#%s%%*'):format(prefix, name, val)
end

local function alias_mode()
  return {
    --Normal
    ['n'] = 'Normal',
    ['no'] = 'O-Pending',
    ['nov'] = 'O-Pending',
    ['noV'] = 'O-Pending',
    ['no\x16'] = 'O-Pending',
    ['niI'] = 'Normal',
    ['niR'] = 'Normal',
    ['niV'] = 'Normal',
    ['nt'] = 'Normal',
    ['ntT'] = 'Normal',
    ['v'] = 'Visual',
    ['vs'] = 'Visual',
    ['V'] = 'V-Line',
    ['Vs'] = 'V-Line',
    ['\x16'] = 'V-Block',
    ['\x16s'] = 'V-Block',
    ['s'] = 'Select',
    ['S'] = 'S-Line',
    ['\x13'] = 'S-Block',
    ['i'] = 'Insert',
    ['ic'] = 'Insert',
    ['ix'] = 'Insert',
    ['R'] = 'Replace',
    ['Rc'] = 'Replace',
    ['Rx'] = 'Replace',
    ['Rv'] = 'V-Replace',
    ['Rvc'] = 'V-Replace',
    ['Rvx'] = 'V-Replace',
    ['c'] = 'Command',
    ['cv'] = 'Ex',
    ['ce'] = 'Ex',
    ['r'] = 'Replace',
    ['rm'] = 'More',
    ['r?'] = 'Confirm',
    ['!'] = 'Shell',
    ['t'] = 'Terminal',
  }
end

function M.mode()
  local alias = alias_mode()
  return {
    stl = function()
      local mode = api.nvim_get_mode().mode
      local m = alias[mode] or alias[string.sub(mode, 1, 1)] or 'UNK'
      return m:sub(1, 3):upper()
    end,
    name = 'mode',
    default = 'NOR',
    event = { 'ModeChanged' },
    attr = {
      bg = stl_bg,
      fg = 'black',
      bold = true,
    },
  }
end

function M.fileinfo()
  return {
    stl = [[%{expand('%:t')}]],
    name = 'fileinfo',
    event = { 'BufEnter' },
    attr = {
      bold = true,
      fg = 'black',
      bg = stl_bg,
    },
  }
end

function M.progress()
  local spinner = { '⣶', '⣧', '⣏', '⡟', '⠿', '⢻', '⣹', '⣼' }
  local idx = 1
  return {
    stl = function(args)
      if args.data and args.data.params then
        local val = args.data.params.value
        if val.message and val.kind ~= 'end' then
          idx = idx + 1 > #spinner and 1 or idx + 1
          return ('%s'):format(spinner[idx - 1 > 0 and idx - 1 or 1])
        end
      end
      return ''
    end,
    name = 'LspProgress',
    event = { 'LspProgress' },
    attr = stl_attr('Type'),
  }
end

function M.lsp()
  return {
    stl = function(args)
      local client = lsp.get_clients({ bufnr = 0 })[1]
      if not client then
        return ''
      end
      local msg = ''
      if args.data and args.data.params then
        local val = args.data.params.value
        if not val.message or val.kind == 'end' then
          msg = ('[%s:%s]'):format(client.name, client.root_dir and fnamemodify(client.root_dir, ':t') or 'single')
        else
          msg = ('%s %s%s'):format(
            val.title,
            (val.message and val.message .. ' ' or ''),
            (val.percentage and val.percentage .. '%' or '')
          )
        end
      elseif args.event == 'BufEnter' or args.event == 'LspAttach' then
        msg = ('[%s:%s]'):format(client.name, client.root_dir and fnamemodify(client.root_dir, ':t') or 'single')
      elseif args.event == 'LspDetach' then
        msg = ''
      end
      return '   %-20s' .. msg
    end,
    name = 'Lsp',
    event = { 'LspProgress', 'LspAttach', 'LspDetach', 'BufEnter' },
  }
end

function M.gitinfo()
  local alias = { 'Head', 'Add', 'Change', 'Delete' }
  for i = 2, 4 do
    local fg = api.nvim_get_hl(0, { name = 'GitSigns' .. alias[i] }).fg
    api.nvim_set_hl(0, 'ModeLineGit' .. alias[i], { fg = fg, bg = stl_bg })
  end
  return {
    stl = function()
      return coroutine.create(function(pieces, idx)
        local signs = { '', '+', '~', '-' }
        local order = { 'head', 'added', 'changed', 'removed' }

        local ok, dict = pcall(api.nvim_buf_get_var, 0, 'gitsigns_status_dict')
        if not ok or vim.tbl_isempty(dict) then
          return ''
        end
        if dict['head'] == '' then
          local co = coroutine.running()
          vim.system({ 'git', 'config', '--get', 'init.defaultBranch' }, { text = true }, function(result)
            coroutine.resume(co, #result.stdout > 0 and vim.trim(result.stdout) or nil)
          end)
          dict['head'] = coroutine.yield()
        end
        local parts = ''
        for i = 1, 4 do
          if i == 1 or (type(dict[order[i]]) == 'number' and dict[order[i]] > 0) then
            parts = ('%s %s'):format(parts, group_fmt('Git', alias[i], signs[i] .. dict[order[i]]))
          end
        end
        pieces[idx] = parts
      end)
    end,
    async = true,
    name = 'git',
    event = { 'User GitSignsUpdate', 'BufEnter' },
  }
end

local function diagnostic_info()
  return function()
    if not vim.diagnostic.is_enabled({ bufnr = 0 }) or #lsp.get_clients({ bufnr = 0 }) == 0 then
      return ''
    end
    local t = {}
    for i = 1, 3 do
      local count = #diagnostic.get(0, { severity = i })
      t[#t + 1] = ('%%#ModeLine%s#%s%%*'):format(vim.diagnostic.severity[i], count)
    end
    return (' Diagnostic[%s]'):format(table.concat(t, ' '))
  end
end

function M.diagnostic()
  for i = 1, 3 do
    local name = ('Diagnostic%s'):format(diagnostic.severity[i])
    local fg = api.nvim_get_hl(0, { name = name }).fg
    api.nvim_set_hl(0, 'ModeLine' .. diagnostic.severity[i], { fg = fg, bg = stl_bg })
  end
  return {
    stl = diagnostic_info(),
    event = { 'DiagnosticChanged', 'BufEnter', 'LspAttach' },
  }
end

function M.eol()
  return {
    name = 'eol',
    stl = (not uv.os_uname().sysname:find('Windows')) and ':' or '(Dos)',
    event = { 'BufEnter' },
  }
end

function M.encoding()
  local map = {
    ['utf-8'] = 'U',
    ['utf-16'] = 'U16',
    ['utf-32'] = 'U32',
    ['unix'] = 'U',
    ['linux'] = 'L',
    ['dos'] = 'W',
  }
  return {
    stl = (' %s%s'):format(map[vim.o.ff], (vim.o.fileencoding and map[vim.o.fileencoding] or map[vim.o.encoding])),
    name = 'filencode',
    event = { 'BufEnter' },
  }
end

-- --------------

M.padding = '%#Normal#%0*'
M.separator = '%='

function M.git_branch()
  return {
    stl = function()
      return coroutine.create(function(pieces, idx, cb)
        local cr = coroutine.running()
        system_exec('git rev-parse --is-inside-work-tree', cr)
        if coroutine.yield().code > 0 then
          return
        end
        system_exec('git rev-parse --abbrev-ref HEAD', cr)
        local rslt = coroutine.yield().stdout
        local name = rslt and vim.trim(rslt) or nil
        if not name then
          return
        end
        pieces[idx] = '  [' .. name .. ']'
        cb()
      end)
    end,
    async = true,
    name = 'git',
    event = { 'User GitSignsUpdate', 'BufEnter' },
  }
end

function M.git_file_status()
  return {
    stl = function()
      return coroutine.create(function(pieces, idx, cb)
        local cr = coroutine.running()
        system_exec('git rev-parse --is-inside-work-tree', cr)
        if coroutine.yield().code > 0 then
          return
        end
        system_exec('git rev-parse --abbrev-ref HEAD', cr)
        local rslt = coroutine.yield().stdout
        local name = rslt and vim.trim(rslt) or nil
        if not name then
          return
        end
        pieces[idx] = '  [' .. name .. ']'
        cb()
      end)
    end,
    async = true,
    name = 'git',
    event = { 'User GitSignsUpdate', 'BufEnter' },
  }
end

return M
