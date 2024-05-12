local header = require("codam-header.header")
local comment = require("codam-header.comment")

local M = {}

-- default setting for the user
local options = {
	author = "marvin",
	email = "marvin@codam.nl",
}

-- Merge user settings with defaults
M.setup = function(opts)
	opts = opts or {}
	for k, v in pairs(options) do
		if opts[k] == nil then
			opts[k] = v
		end
	end
	options = opts
end

-- insert header
M.insert = function()
	local buffnr = vim.api.nvim_get_current_buf()
	print("buffnr: ", buffnr)
	local com_signs = comment.Get_comment(buffnr)

	if com_signs == nil then
		return false
	end

	return header.Insert_header(options, com_signs, buffnr)
end

return M
