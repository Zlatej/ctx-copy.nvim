local M = {}

---@class CtxCopyConfig
---@field keymap table
---@field prefixes string[]
---@field remove_indent boolean

---@type CtxCopyConfig
M.defaults = {
	keymap = {
		cp_context = "<leader>cc",
		cp_line = "<leader>cl",
		cp_visual = "<leader>cc",
	},
	-- Prefixes to strip absolute path
	prefixes = {},
	remove_indent = true,
}

---@type CtxCopyConfig
M.options = {}

function M.setup(custom_opts)
	custom_opts = custom_opts or {}
	if custom_opts.prefix and custom_opts.prefix ~= "" then
		if not custom_opts.prefixes then
			custom_opts.prefixes = {}
		end
		table.insert(custom_opts.prefixes, 1, custom_opts.prefix)
		vim.notify("ctx-copy.nvim: 'prefix' option is deprecated, use 'prefixes' array instead", vim.log.levels.WARN)
		custom_opts.prefix = nil
	end
	M.options = vim.tbl_deep_extend("force", M.defaults, custom_opts)
	return M.options
end

return M
