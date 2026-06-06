return {
	{
		-- Highlight, edit, and navigate code
		'nvim-treesitter/nvim-treesitter',
		branch = 'main',
		dependencies = {
			{ 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'main' },
		},
		build = ':TSUpdate',
		init = function()
			-- Parser installation
			local ensureInstalled = { 'go', 'lua', 'vimdoc', 'vim', 'bash', 'zig', 'javascript', 'python' }
			local alreadyInstalled = require('nvim-treesitter.config').get_installed()
			local toInstall = vim.iter(ensureInstalled)
				:filter(function(p) return not vim.tbl_contains(alreadyInstalled, p) end)
				:totable()
			require('nvim-treesitter').install(toInstall)

			-- Highlighting + indentation via FileType autocmd
			vim.api.nvim_create_autocmd('FileType', {
				callback = function()
					pcall(vim.treesitter.start)
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end,
	}
}
