-- Add blank space above
local blank_above = function()
  vim.cmd("put! =repeat(nr2char(10), v:count1)|silent ']+")
end

-- Add blank space below
local blank_below = function()
  vim.cmd("put =repeat(nr2char(10), v:count1)|silent '[-")
end

local homeVsKey = function()
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
local brem = function()
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
