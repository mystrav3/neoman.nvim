local Config = {}


local inp_w = 40
local inp_h = 1
local dis_w = 160
local dis_h = 40


function Center_height(in_h)
	local height = vim.api.nvim_win_get_height(0)
	local out = ((height / 2) - (in_h / 2))
	return out
end


function Center_width(in_w)
	local width = vim.api.nvim_win_get_width(0)
	local out = ((width / 2) - (in_w / 2))
	return out
end

local config = {
	user_input = {},
	user_display = {},
	default_input = {
		relative = "editor",
		row = Center_height(inp_h),
		col = Center_width(inp_w),
		focusable = true,
		style = "minimal",
		border = "rounded",
		width = inp_w,
		height = inp_h,
		title = "NeoMan",
	},
	default_display = {
		relative = "editor",
		row = Center_height(dis_h),
		col = Center_width(dis_w),
		focusable = true,
		style = "minimal",
		border = "rounded",
		width = dis_w,
		height = dis_h,
		title = '',
	},
}




config.set_input_config = function (in_config)
	if in_config ~= nil then
		config.user_input = in_config
	else
		config.user_input = {}
	end
end


config.set_display_config = function (in_config)
	if in_config ~= nil then
		config.user_display = in_config
	else
		config.user_display = {}
	end
end


config.get_input_config = function ()
	if config.user_input ~= {} then
		return config.user_input
	else
		return config.default_input
	end
end


config.get_display_config = function ()
	if config.user_display ~= {} then
		return config.user_display
	else
		return config.default_display
	end
end


Config.new = function ()
	return config
end


return Config
