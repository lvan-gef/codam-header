-- ************************************************************************** --
--                                                                            --
--                                                        ::::::::            --
--   init.lua                                           :+:    :+:            --
--                                                     +:+                    --
--   By: lvan-gef <lvan-gef@student.codam.nl>         +#+                     --
--                                                   +#+                      --
--   Created: 2024/06/15 22:05:47 by lvan-gef      #+#    #+#                 --
--   Updated: 2024/06/15 22:05:50 by lvan-gef      ########   odam.nl         --
--                                                                            --
-- ************************************************************************** --

local header = require("codam-header.header")
local comment = require("codam-header.comment")

local M = {}

-- default setting for the user
local options = {
	author = "marvin",
	email = "marvin@codam.nl",
}

--- Merge user settings with defaults
--- @param opts table
M.setup = function(opts)
	opts = opts or {}
	for k, v in pairs(options) do
		if opts[k] == nil then
			opts[k] = v
		end
	end
	options = opts
end

--- insert header
--- @return boolean
M.insert = function()
	local buffnr = vim.api.nvim_get_current_buf()
	local com_sign = comment.Get_comment(buffnr)

	if com_sign == nil then
		return false
	end

	return header.Insert_header(options, com_sign, buffnr)
end

--- update header
--- @return boolean
M.update = function()
	local buffnr = vim.api.nvim_get_current_buf()
	local com_sign = comment.Get_comment(buffnr)

	if com_sign == nil then
		return false
	end

	return header.Update_header(options, com_sign, buffnr)
end

return M
