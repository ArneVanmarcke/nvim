local lsp_zero= require('lsp-zero')

lsp_zero.on_attach(function(client,bufnr)
	lsp_zero.default_keymaps({buffer = bufnr})
end)

--Automatic LSP Server setup
require('mason').setup({})
require('mason-lspconfig').setup({
	--:LSPInstall
	ensure_installed = {'tsserver','rust_analyzer','jdtls'},
	handlers = {
		lsp_zero.default_setup,
		lua_ls = function()
			local lua_opts = lsp_zero.nvim_lua_ls()
			require('lspconfig').lua_ls.setup(lua_opts)
		end,
	},
})

--Autocomplete
local cmp = require('cmp')
local cmp_action = lsp_zero.cmp_action()

cmp.setup({
	mapping = cmp.mapping.preset.insert({
		--Enter to confirm completion
		['<TAB>'] = cmp.mapping.confirm({select = true}),
		--Ctrl+Space trigger completion menu
		['<C-Space>'] = cmp.mapping.complete(),

		['<C-f>'] = cmp_action.luasnip_jump_forward(),
		['<C-b>'] = cmp_action.luasnip_jump_backward(),

		['<C-u>'] = cmp.mapping.scroll_docs(-4),
		['<C-d>'] = cmp.mapping.scroll_docs(4),
	})
})
