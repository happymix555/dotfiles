return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			vim.lsp.enable('pyright')
			vim.lsp.config('lua-language-server')
			vim.lsp.enable('lua-language-server')
		end,
	}
}
