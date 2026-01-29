local File = {}
local file = {
	name = '',
	_length = '',
	lines = {},
	cur_y = 1,
        cur_x = 1
}



file.save = function (name, win_tbl)
	file.flush()
	file.name = name
	file._length = vim.api.nvim_buf_line_count(win_tbl.buffer)

	local cur_pos = vim.fn.getcurpos(win_tbl.win_id)

	file.cur_y = cur_pos[2]
	file.cur_x = cur_pos[3]

	file.lines = vim.api.nvim_buf_get_lines(win_tbl.buffer, 0, -1, true)
end


file.load = function (win_tbl)
	vim.api.nvim_buf_set_lines(win_tbl.buffer, 0, -1, true, file.lines)

	if file.cur_y ~= nil and file.cur_x ~= nil then
		vim.api.nvim_win_set_cursor(win_tbl.win_id, {file.cur_y, file.cur_x})
	else
		vim.api.nvim_win_set_cursor(win_tbl.win_id, {1, 1})
	end
end


file.flush = function ()
	file.name = ''
	file._length = 0
	file.lines = {}
	file.cur_y = 1
	file.cur_x = 1
end


File.new = function ()
	return file
end



return File
