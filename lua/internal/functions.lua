local M = {}

--
-- This function search the match in ruls to find a specific file name
-- @param fname string path to file
-- @param rule table
function search_match_file(fname, rules)
  for rule, aditionals in pairs(rules) do
    if vim.fn.match(fname, rule) ~= -1 then
      for key, ad in pairs(aditionals) do
        local newFn = ad .. fname
        if vim.fn.filereadable(newFn) == 1 then
          return newFn
        end
      end
    end
  end
end

--
-- Go To File HTML
-- @param fname string path to fname
M.gotofile_html = function(fname)
  local rules = {
    ['^/'] = {
      '..',
      '.',
      'src',
    },
  }
  local newFn = search_match_file(fname, rules)
  return newFn or fname
end

--
-- Go To File VUE
-- @param fname string filename in path to find
M.gotofile_vue = function(fname)
  if string.match(fname, '^@') == '@' then
    -- search inside the fname
    local viteConfig = Load_main_node_module('vite.config.js')
    if vim.fn.filereadable(viteConfig) == 1 then
      local configContent = vim.fn.readfile(viteConfig)
      local aliasDefinition
      for _, line in ipairs(configContent) do
        -- Busca la definición de alias
        if string.match(line, '[\'"]@[\'"]%s*:%s*[\'"](.*)[\'"],') then
          aliasDefinition = string.match(line, '[\'"]@[\'"]%s*:%s*[\'"](.*)[\'"],')
        end
      end
      if aliasDefinition then
        -- replace
        fname = string.gsub(fname, '^@', aliasDefinition)
      end
    end

    return fname
  else
    -- El nombre del archivo no comienza con "@".
    -- Procede con la lógica original.
    local rules = {
      ['^/'] = {
        '..',
        '.',
        'src',
      },
    }
    return search_match_file(fname, rules) or fname
  end
end

--
-- If is aviable a plugin in lazy plugin manager
-- @param plugin string name of plugin
function M.is_available(plugin)
  local lazy_config_avail, lazy_config = pcall(require, 'lazy.core.config')
  return lazy_config_avail and lazy_config.spec.plugins[plugin] ~= nil
end

--
--
-- Add blank space above
M.blank_above = function()
  vim.cmd("put! =repeat(nr2char(10), v:count1)|silent ']+")
end

-- Add blank space below
M.blank_below = function()
  vim.cmd("put =repeat(nr2char(10), v:count1)|silent '[-")
end

-- Home key
M.homeVsKey = function()
  local col = vim.fn.col('.')
  local line = vim.api.nvim_get_current_line()
  local nonBlankColumn = vim.fn.match(line, '\\S') + 1
  if col == nonBlankColumn then
    action = 'g0'
  else
    action = '^'
  end
  return action
end

-- Remove buffer
M.brem = function()
  -- if there are less than 2
  if vim.fn.winnr('$') < 2 then
    vim.cmd('bw')
    return
  end
  -- there are at least 2 windows
  -- if there are less that 2 bufers
  if vim.fn.bufnr('$') < 2 then
    vim.cmd('enew')
  end
  vim.cmd('bn |  bw #')
end

-- Toggle netrw
M.toggleNetrw = function()
  -- Verificar si el buffer de netrw ya está abierto
  local netrw_buf_exists = false
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_get_option(buf, 'filetype') == 'netrw' then
      netrw_buf_exists = true
      break
    end
  end

  -- Abrir Vexprore si el buffer de netrw no está abierto
  if not netrw_buf_exists then
    --vim.cmd("Vexplore")
    vim.cmd('Explore %:p:h')
  else
    -- Obtener el número del buffer actual
    local current_buf = vim.api.nvim_get_current_buf()

    -- Verificar si el buffer actual es netrw
    if vim.api.nvim_buf_get_option(current_buf, 'filetype') == 'netrw' then
      -- Cerrar el buffer actual
      vim.cmd('bd')
    else
      -- Enfocar el buffer de netrw
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.api.nvim_buf_get_option(buf, 'filetype') == 'netrw' then
          vim.api.nvim_set_current_win(win)
          break
        end
      end
    end
  end
end

-- Surround selection
M.vsurround = function()
  local char_code = vim.fn.getchar()
  local char = vim.fn.nr2char(char_code)
  if char == '\x03' or char == '\x1b' then
    return
  end
  local surrounds = {
    ['('] = ')',
    ['['] = ']',
    ['{'] = '}',
    ['<'] = '>',
    -- ' " ` = are the same
  }
  local pair_char = surrounds[char] or char
  return 'c' .. char .. '<C-r><C-o>"' .. pair_char .. '<ESC><Left>vi' .. char
end

------------------
return M
