local M ={}

--- Return if in the kernel plugins options is selected some
--- value, return nil if is not defined de vdef
function M.selected_plugin(name, cval)
  local sv = _kernel.options.plugins[name]
  return sv == cval
end

return M
