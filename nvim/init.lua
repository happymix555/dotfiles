vim.opt.tabstop=4
vim.opt.shiftwidth=4
vim.opt.number = true
vim.o.list = true
vim.opt.listchars = {
  tab = '> ',     -- ✅ must be exactly two characters
  trail = '·',
  extends = '›',
  precedes = '‹',
  nbsp = '␣',
  space = '.',
}

require("config.lazy")

vim.cmd.colorscheme("catppuccin-latte")

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = { 
	"c", 
	"lua", 
	"vim", 
	"vimdoc", 
	"query", 
	"markdown", 
	"markdown_inline",
	"python",
	"javascript",	
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },

  indent = {
    enable = true
  },
}
