--local lsp_zero= require('lsp-zero')

--[[lsp_zero.on_attach(function(client,bufnr)
	lsp_zero.default_keymaps({buffer = bufnr})
end)

--Automatic LSP Server setup
require('mason').setup({})
require('mason-lspconfig').setup({
	--:LSPInstall
	ensure_installed = {'tsserver','rust_analyzer','gopls','pyright'},
	handlers = {
		lsp_zero.default_setup,
		lua_ls = function()
			local lua_opts = lsp_zero.nvim_lua_ls()
			require('lspconfig').lua_ls.setup(lua_opts)
		end,
	},
})]]

local lspconfig = require('lspconfig')

lspconfig.pyright.setup{}
lspconfig.tsserver.setup{}
lspconfig.gopls.setup{}
lspconfig.rust_analyzer.setup{}
lspconfig.lua_ls.setup{}

--Trigger autocomplete popup
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local luasnip = require('luasnip')

local servers = {
	"lua_ls",
	"tsserver",
	"gopls",
	"pyright",
	"rust_analyzer"
}

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		capabilities = capabilities
	})
end

--Autocomplete
local cmp = require('cmp')
--local cmp_action = lspconfig.cmp_action()

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	sources = {
		{ name = 'nvim_lsp' },
		{ name = "buffer" },
	},
	mapping = cmp.mapping.preset.insert({
		--Enter to confirm completion
		['<TAB>'] = cmp.mapping.confirm({
			--behavior = cmp.ConfirmBehaviour.Replace,
			select = true
		}),
		--Ctrl+Space trigger completion menu
		['<C-Space>'] = cmp.mapping.complete(),
		
		--[[
		['<C-f>'] = cmp_action.luasnip_jump_forward(),
		['<C-b>'] = cmp_action.luasnip_jump_backward(),
		]]

		['<C-u>'] = cmp.mapping.scroll_docs(-4),
		['<C-d>'] = cmp.mapping.scroll_docs(4),
	})
})
