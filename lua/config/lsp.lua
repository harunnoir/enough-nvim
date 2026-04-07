-- Enable Language Server Protocol servers
vim.lsp.enable 'basedpyright'
vim.lsp.enable 'clangd'
vim.lsp.enable 'lua_ls'
vim.lsp.enable 'ts_ls'

-- Configure lua_ls (Lua language server)
vim.lsp.config.lua_ls = {
	filetypes = { 'lua' },
	settings = {
		Lua = {
			diagnostics = { globals = { 'vim' } },
			runtime = { version = 'LuaJIT' },
		},
	},
}

-- Configure diagnostic signs
vim.diagnostic.config {
	signs = {
		text = {
			ERROR = '',
			WARN = '',
			HINT = '',
			INFO = '',
		},
	},
}

-- Enable inlay hints for all LSP clients on attach
vim.api.nvim_create_autocmd('LspAttach', {
	callback = function()
		vim.lsp.inlay_hint.enable(true)
	end,
})
