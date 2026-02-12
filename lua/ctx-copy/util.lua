local M = {}

---@param str string
---@return string
function M.trim_indent(str)
	return str:match("^%s*(.-)%s*$")
end

---@param path string
---@return string
function M.trim_slash(path)
	if path:sub(1, 1) == "/" then
		return path:sub(2)
	end
	return path
end

---@param path string
---@param prefixes string[]
---@return string
function M.remove_prefix_path(path, prefixes)
	for _, fragment in ipairs(prefixes) do
		path = M.trim_slash(path)
		fragment = M.trim_slash(fragment)
		if path:sub(1, #fragment) == fragment then
			path = path:sub(#fragment + 1)
		end
	end
	return M.trim_slash(path)
end

return M
