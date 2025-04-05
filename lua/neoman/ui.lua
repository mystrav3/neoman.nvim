--package.path = "./lua/neoman/?.lua"

local File = require("neoman.file")
local Window = require("neoman.window")
local Config = require("neoman.config")
local Map = require("neoman.map")



local Ui = {}

local ui = {
	input_win = Window.new(),
	display_win = Window.new(),
	config = Config.new(),
	file_cache = File.new(),
	keymaps = Map.new(),
	display_open = false,
	input_open = false,
	query = "",
}


local display_on_esc = function ()
	ui.file_cache.flush()
	ui.file_cache.save(ui.query, ui.display_win)
	ui.display_win.close()
	ui.display_open = false

	vim.keymap.del("n", "<esc>")
end


local input_on_enter = function ()
	local line = vim.api.nvim_buf_get_lines(ui.input_win.buffer, 0, -1, true)
	ui.query = line[1]
	ui.input_win.close()
	ui.input_open = false

	vim.keymap.del({"n", "v", "i"}, "<cr>")
	vim.keymap.del("n", "<esc>")

	vim.cmd("stopinsert")

	if ui.query ~= nil or ui.query ~= "" then
		ui.display_win.set_config(ui.config.default_display)
		ui.display_win.create()
		ui.display_open = true

		vim.cmd(string.format('read !man %s', ui.query))

		vim.keymap.set("n", "<esc>", function () display_on_esc() end)
	else
		vim.notify("No Search Term Entered", 4)
	end

end


local input_on_esc = function ()
	ui.input_win.close()
	ui.input_open = false

	vim.cmd("stopinsert")

	vim.keymap.del({"n", "v", "i"}, "<cr>")
	vim.keymap.del("n", "<esc>")
end


ui.search = function ()
	if ui.display_open == true then
		ui.display_win.close()
		ui.display_open = false
	end

	ui.input_win.set_config(ui.config.default_input)
	ui.input_win.create()
	ui.input_open = true

	vim.api.nvim_win_set_cursor(ui.input_win.win_id, {1, 1})

	vim.cmd("startinsert")

	vim.keymap.set({"n", "v", "i"}, "<cr>", function () input_on_enter() end)
	vim.keymap.set("n", "<esc>", function () input_on_esc() end)
end


ui.toggle_display = function ()
	if ui.display_open == false then
		if ui.query ~= nil or ui.query ~= "" then
			ui.display_win.set_config(ui.config.default_display)
			ui.display_win.create()
			ui.display_open = true


			vim.cmd(string.format("read !man %s", ui.query))

			vim.keymap.set("n", "<esc>", function () display_on_esc() end)
		else
			vim.notify("No Search Term Entered", 4)
		end
	elseif ui.display_open == true then
		display_on_esc()
	end
end


Ui.new = function ()
	return ui
end


return Ui
