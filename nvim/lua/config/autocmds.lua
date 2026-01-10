-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Force tabs instead of spaces for ALL files
vim.api.nvim_create_autocmd({ "FileType", "BufEnter", "BufWinEnter" }, {
  pattern = "*",
  callback = function()
    vim.bo.expandtab = false
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.softtabstop = 4
  end,
})

-- Make window separators dark (set after colorscheme loads)
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#2e2e2e", bg = "NONE", bold = true })
    vim.api.nvim_set_hl(0, "VertSplit", { fg = "#2e2e2e", bg = "NONE", bold = true })
  end,
})

-- Apply separator color immediately on startup
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#2e2e2e", bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "VertSplit", { fg = "#2e2e2e", bg = "NONE", bold = true })
