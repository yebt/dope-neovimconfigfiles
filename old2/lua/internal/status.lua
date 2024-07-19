local opt = vim.opt

local statusline_str = ''
local tabline_str = ''

--
local padding = '%#Normal# %0*' -- xpadding
local separator = '%=' -- separator

--
function append_v(v, chrl, chrr, vl)
  if v and v ~= '' then
    return chrl .. v .. chrr .. ' '
  else
    return vl or ''
  end
end

function lazyupdates()
  local ok, lst = pcall(require, 'lazy.status')
  if not ok or not (lst.has_updates()) then
    return ''
  end
  return ' ' .. require('lazy.status').updates() .. ' '
end

_G.guard_status_w = function()
  if _G.guard_status then
    return _G.guard_status()
  end
  return ''
end

--
-- local agroup = vim.api.nvim_create_augroup
-- local au = vim.api.nvim_create_autocmd
vim.api.nvim_create_autocmd({ 'LspAttach' }, {
  buffer = 0,
  callback = function(args)
    local lspcs = vim.lsp.get_clients({ bufnr = 0 })
    if #lspcs == 0 then
      return
    end

    local names = ''
    for _, cl in ipairs(lspcs) do
      if #names == 0 then
        names = cl.name
      else
        names = names .. ', ' .. cl.name
      end
    end
    vim.b.lsp_clients = names
  end,
})

-- _G.lsp_clients = function()
--   local lspcs = vim.lsp.get_clients({ bufnr = 0 })
--   if #lspcs == 0 then
--     return ''
--   end
--
--   local names = ''
--   for _, cl in ipairs(lspcs) do
--     if #names == 0 then
--       names = cl.name
--     else
--       names = names .. ', ' .. cl.name
--     end
--   end
--   return '[ ' .. names .. ' ]'
-- end

--
local stts_str = padding
  .. "%1*%{ v:lua.append_v(get(b:,'gitsigns_head',''),'  [', ']')}%0*"
  -- .. "%1*%{ v:lua.append_v(get(b:,'walo_git_head_cwd',''),'  [', ']')}%0*"
  -- .. "%{ get(g:, 'walo_git_head_cwd','') }!"
  -- .. ' %<%f '
  -- .. '%h%m%r'
  .. '%{v:lua.guard_status_w() }'
  .. separator
  -- diagnostic
  -- servers
  .. "%1*%{ v:lua.append_v(get(b:,'lsp_clients',''),' 󰿘 [', ']')}%0*"
  .. separator
  --.. '%2*%{v:lua.Lazyupdates()}%0*' -- Updates
  .. '%2*%{v:lua.lazyupdates()}%0*'
  .. ' %2l/%L:%c '
  .. '%{ mode() }'
  .. padding

--
tabline_str = ''
tabline_str = '%0*%#TabLine#%#TabLineSel#> %<%f %h%m%r %0*'

--
opt.statusline = stts_str
opt.tabline = tabline_str
