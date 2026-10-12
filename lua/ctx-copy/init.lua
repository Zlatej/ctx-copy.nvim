local util = require("ctx-copy.util")
local M = {}

local cfg = {}
local ns = vim.api.nvim_create_namespace("ctx-copy")

function M.setup(opts)
	local config = require("ctx-copy.config")
	cfg = config.setup(opts)

	-- Line
	vim.api.nvim_create_user_command("CopyLine", M.copy_line, {})
	vim.keymap.set("n", cfg.keymap.cp_line, M.copy_line, { desc = "Copy line with context" })
	-- Context
	vim.api.nvim_create_user_command("CopyContext", M.copy_context, {})
	vim.keymap.set("n", cfg.keymap.cp_context, M.copy_context, { desc = "Copy context" })
	-- Visual ("x", not "v", "v" also maps Select mode)
	vim.keymap.set("x", cfg.keymap.cp_visual, M.copy_selection, { desc = "Copy visual selection" })
end

function M.copy_line()
	local line = vim.api.nvim_get_current_line()
	if cfg.remove_indent then
		line = util.trim_indent(line)
	end
	M.copy(line)
	local line_num = vim.fn.line(".")
	print("Copied line " .. line_num .. ": " .. line)
end

function M.copy_context()
	local res = M.copy("")
	print("Copied context: " .. res)
end

function M.copy_selection()
	local lines = vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."), { type = vim.fn.mode() })
	if cfg.remove_indent then
		lines = util.dedent(lines)
	end

	M.copy(table.concat(lines, "\n"))
	vim.hl.range(0, ns, "IncSearch", "v", ".", {
		regtype = vim.fn.mode(),
		inclusive = true,
		timeout = 150,
	})
	vim.cmd("normal! \27") -- leave visual mode

	print("Copied " .. #lines .. " lines")
end

---@param selection string
---@return string
function M.copy(selection)
	local file = vim.fn.expand("%:p")
	file = util.remove_prefix_path(file, cfg.prefixes)
	local line_num = math.min(vim.fn.line("."), vim.fn.line("v"))

	local res
	if #selection ~= 0 then
		res = string.format("%s:%d\n%s", file, line_num, selection)
	else
		res = string.format("%s:%d", file, line_num)
	end

	vim.fn.setreg("+", res)
	return res
end

return M
