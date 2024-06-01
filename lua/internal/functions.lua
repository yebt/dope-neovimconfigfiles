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

------------------
return M
