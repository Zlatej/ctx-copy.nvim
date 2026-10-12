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

---@param lines string[]
---@return string[]
function M.dedent(lines)
	local min_indent = math.huge
	local out = {}

	for _, line in ipairs(lines) do
		if line:match("%S") then
			min_indent = math.min(min_indent, #line:match("^%s*"))
		end
	end

	if min_indent == math.huge then
		return lines
	end

	for _, line in ipairs(lines) do
		table.insert(out, line:sub(min_indent + 1))
	end
	return out
end

return M
