local agroup = vim.api.nvim_create_augroup
local au = vim.api.nvim_create_autocmd
local cmd = vim.cmd

local function ag(name)
  return agroup('_bootstrap_' .. name, { clear = true })
end
