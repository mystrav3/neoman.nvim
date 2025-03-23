local Map = {}

local keymap = {
	saved_keys = {}
}


keymap.search = function (m, lhs)
	if #keymap.saved_keys == 0 then
		return 0
	end

	local tbl = {m, lhs}

	for i = 1, #keymap.saved_keys, 1 do
		if keymap.saved_keys[i] == tbl then
			return i
		end
	end

	return 0
end


keymap.map = function (m, lhs, f)
	local result = keymap.search(m, lhs)
	if result == 0 then
		vim.keymap.set(m, lhs, f)

		table.insert(keymap.saved_keys, {m, lhs})
		return 0
	else
		return 1
	end
end


keymap.unmap = function (m, lhs)
	if #keymap.saved_keys == 0 then
		return nil
	end

	local result = keymap.search(m, lhs)
	if result == 0 then
		return 1
	else
		vim.keymap.del(m, lhs)

		table.remove(keymap.saved_keys, result)
	end
end


Map.new = function ()
	return keymap
end


return Map
