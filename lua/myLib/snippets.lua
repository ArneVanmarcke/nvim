local M = {}

function M.error_snippet()
	local case = {
		['go'] = [[
			if err != nil {
				// Add code here
			}
		]]
	}

	local filetype = vim.bo.filetype
	local body = case[filetype]
	if body then
		local curr_line = vim.api.nvim_win_get_cursor(0)[1]
		vim.api.nvim_buf_set_lines(0, curr_line, curr_line, false, vim.split(body, '\n'))
		vim.lsp.buf.format({ async = true })
	end
end

return M
