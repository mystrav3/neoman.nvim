--package.path = "./lua/neoman/?.lua"
local Ui = require("neoman.ui")



local Neoman = {}


local ui = Ui.new()


Neoman.search = function ()
	ui.search()
end


Neoman.toggle = function ()
	ui.toggle_display()
end


vim.api.nvim_create_user_command("NeomanSearch", function ()
	require("neoman").search()
end, {})
vim.api.nvim_create_user_command("NeomanToggle", function ()
	require("neoman").toggle()
end, {})


return Neoman
