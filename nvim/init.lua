-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
-- show line number on the left hand side
vim.opt.number = true
-- show invisible characters like tab, space, etc.
vim.o.list = true
-- defind how invisible characters are displayed
vim.opt.listchars = {
	tab = "> ", -- ✅ must be exactly two characters
	trail = "·",
	extends = "›",
	precedes = "‹",
	nbsp = "␣",
	space = ".",
}
-- use system clipboard as a default
vim.opt.clipboard = "unnamedplus"
-- load the lazy plugin manager
-- this will help load other plugins we installed via Lazy
require("config.lazy")
