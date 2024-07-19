--
function gotofilevue(fname)
  return require("internal.functions").gotofile_vue(fname)
end
vim.opt.includeexpr = "v:lua.gotofilevue(v:fname)"
