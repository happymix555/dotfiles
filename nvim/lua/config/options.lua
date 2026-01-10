-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Disable auto-formatting on save
vim.g.autoformat = false

vim.opt.autoindent = true -- Copy indent from current line when starting a new line
vim.opt.smartindent = true -- Smart autoindenting when starting a new line

-- Show whitespace characters (spaces and tabs)
vim.opt.list = true
vim.opt.listchars = { tab = "→ ", space = "·", trail = "•", nbsp = "␣" }

-- Make window separators more visible with thinner lines
vim.opt.fillchars = {
	vert = "┃", -- Thick line vertical separator
	vertleft = "┃",
	vertright = "┃",
	horiz = "━",
	horizup = "┻",
	horizdown = "┳",
}
