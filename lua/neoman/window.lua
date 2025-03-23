local Window = {}


local window = {
	win_id = 0,
	buffer = 0,
	config = {},
}


window.create = function ()
	window.buffer = vim.api.nvim_create_buf(false, true)
	window.win_id = vim.api.nvim_open_win(window.buffer, true, window.config)
end


window.set_config = function (win_config)
	window.config = win_config
end


window.close = function ()
	vim.api.nvim_win_close(window.win_id, true)
	vim.api.nvim_buf_delete(window.buffer, {})
	window.win_id = 0
	window.buffer = 0
end


Window.new = function ()
	return window
end


return Window
