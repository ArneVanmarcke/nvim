-- require("myLib.snippets")

vim.api.nvim_create_autocmd('FileType', {
	pattern = 'go',
	callback = function ()
		vim.api.nvim_buf_set_keymap(0, 'n', '<leader>err',
			':lua require("myLib.snippets").error_snippet()<CR>',
			{ noremap = true, silent = true })
	end
})
