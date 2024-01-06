local keymap = require("core.keymap")
local nmap, imap, cmap, xmap = keymap.nmap, keymap.imap, keymap.cmap, keymap.xmap
local silent, noremap = keymap.silent, keymap.noremap
local opts = keymap.new_opts
local cmd = keymap.cmd

local map = vim.keymap.set

---------------

-- Home
local homeVsKey = function()
  local col = vim.fn.col(".")
  local line = vim.api.nvim_get_current_line()
  local nonBlankColumn = vim.fn.match(line, "\\S") + 1
  if col == nonBlankColumn then
    action = "g0"
  else
    action = "^"
  end
  return action
end

-- Remove buffer
local brem = function()
  -- if there are less than 2
  if vim.fn.winnr("$") < 2 then
    vim.cmd("bw")
    return
  end
  -- there are at least 2 windows
  -- if there are less that 2 bufers
  if vim.fn.bufnr("$") < 2 then
    vim.cmd("enew")
  end
  vim.cmd("bn |  bw #")
end

---------------
-- Use space as leader key
vim.g.mapleader = " "
vim.g.localmapleader = ","

-- leaderkey
nmap({ " ", "", opts(noremap) })
xmap({ " ", "", opts(noremap) })

--
xmap({ "<leader>y", "a", opts()})

-- usage example
nmap({
	-- noremal remap
	-- close buffer
	{ "<M-c>", cmd("bdelete"), opts(noremap, silent, "Close buffer") },
	-- save
	{ "<leader>w", cmd("write"), opts(noremap, "Save Buffer") },
	-- quit
	{ "<leader>q", cmd("quit"), opts(noremap, "Quit of buffer") },
	-- yank
	{ "<leader>yy", '"+yy', opts(noremap, "Yank on clipboard") },
	{ "Y", "y$", opts(noremap) },
	{ "<leader>Y", '"+y$', opts(noremap, "Yanc to end to clipboard") },
	-- buffer jump
	{ "]b", cmd("bn"), opts(noremap) },
	{ "[b", cmd("bp"), opts(noremap) },
	-- remove trailing white space
	{ "<Leader>t", cmd("TrimTrailingWhitespace"), opts(noremap) },
	-- window jump
	{ "<C-h>", "<C-w>h", opts(noremap) },
	{ "<C-l>", "<C-w>l", opts(noremap) },
	{ "<C-j>", "<C-w>j", opts(noremap) },
	{ "<C-k>", "<C-w>k", opts(noremap) },
})

imap({
	-- insert mode
	{ "<C-h>", "<Bs>", opts(noremap) },
	{ "<C-e>", "<End>", opts(noremap) },
})

-- commandline remap
cmap({ "<C-b>", "<Left>", opts(noremap) })
-- usage of plugins
nmap({
	-- plugin manager: Lazy.nvim
	{ "<Leader>pu", cmd("Lazy update"), opts(noremap, silent) },
	{ "<Leader>pi", cmd("Lazy install"), opts(noremap, silent) },
	-- dashboard
	{ "<Leader>n", cmd("DashboardNewFile"), opts(noremap, silent) },
	{ "<Leader>ss", cmd("SessionSave"), opts(noremap, silent) },
	{ "<Leader>sl", cmd("SessionLoad"), opts(noremap, silent) },
	-- nvimtree
	{ "<Leader>e", cmd("NvimTreeToggle"), opts(noremap, silent) },
	-- Telescope
	{ "<Leader>b", cmd("Telescope buffers"), opts(noremap, silent) },
	{ "<Leader>fa", cmd("Telescope live_grep"), opts(noremap, silent) },
	{ "<Leader>ff", cmd("Telescope find_files"), opts(noremap, silent) },
})

------------------------

map({ "x", "i", "n" }, "<C-c>", "<ESC>", { silent = true, desc = "Stop on esc" })
