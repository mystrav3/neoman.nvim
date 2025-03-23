local File = {}
local file = {
	name = '',
	_length = '',
	lines = {},
	cur_y = 0,
	cur_x = 0,
}


file.save = function (name, win_tbl)
	file.name = name
	file._length = vim.api.nvim_buf_line_count(win_tbl.buffer)
	file.cur_y, file.cur_x = vim.api.nvim_win_get_cursor(win_tbl.win_id)
	file.lines = vim.api.nvim_buf_get_lines(win_tbl.buffer, 0, -1, true)
end


file.load = function (win_tbl)
	vim.api.nvim_buf_set_lines(win_tbl.buffer, 0, -1, true, file.lines)

	vim.api.nvim_win_set_cursor(win_tbl.win_id, {file.cur_y[1], file.cur_x[1]})
end


file.flush = function ()
	file.name = ''
	file._length = 0
	file.cur_y = 0
	file.cur_x = 0
	file.lines = {}
end


File.new = function ()
	return file
end



return File
