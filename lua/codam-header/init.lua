-- Prevent the plugin from being loaded more than once
if vim.g.loaded_codamheader then
    return
end

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

-- set global state to be loaded
vim.g.loaded_codamheader = 1

-- insert header
M.insert = function()
	local buffnr = vim.api.nvim_get_current_buf()
	local com_sign = comment.Get_comment(buffnr)

	if com_sign == nil then
		return false
	end

	return header.Insert_header(options, com_sign, buffnr)
end

-- update header
M.update = function()
	local buffnr = vim.api.nvim_get_current_buf()
	local com_sign = comment.Get_comment(buffnr)

	if com_sign == nil then
		return false
	end

	return header.Update_header(options, com_sign, buffnr)
end

return M
