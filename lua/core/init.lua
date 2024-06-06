-- reset
local pre_path = vim.opt.rtp
vim.opt.rtp="~/.config/nvim"


--- Load las opts
require('core.options')
--- set map
--- restore rtp
vim.opt.rtp= pre_path
