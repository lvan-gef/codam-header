-- ************************************************************************** --
--                                                                            --
--                                                        ::::::::            --
--   header.lua                                         :+:    :+:            --
--                                                     +:+                    --
--   By: lvan-gef <lvan-gef@student.codam.nl>         +#+                     --
--                                                   +#+                      --
--   Created: 2024/06/15 22:05:56 by lvan-gef      #+#    #+#                 --
--   Updated: 2024/06/15 22:06:48 by lvan-gef      ########   odam.nl         --
--                                                                            --
-- ************************************************************************** --

local header = {}

local header_wide = 80

-- Is a mapping for the codam header
-- Every row has at least 2 elements in side it
-- Every element has the following layout: {value of the field, char to pad the field, end column}
-- There are also hardcoded names in the field please don't change them: prefix, filename, author, update_author, email_author, dt, suffix
local lines_table = {
  { { "prefix", " ", 3 }, { "*", "*", header_wide },     { "suffix", " ", header_wide } },
  { { "prefix", " ", 3 }, { "suffix", " ", header_wide } },
  { { "prefix", " ", 3 }, { " ", " ", 58 },              { "::::::::", " ", header_wide }, { "suffix", " ", header_wide } },
  {
    { "prefix",     " ", 3 },
    { " ",          " ", 5 },
    { "filename",   " ", 56 },
    { ":+:    :+:", " ", header_wide },
    { "suffix",     " ", header_wide },
  },
  { { "prefix", " ", 3 }, { " ", " ", 55 }, { "+:+", " ", header_wide }, { "suffix", " ", header_wide } },
  {
    { "prefix",       " ", 3 },
    { " ",            " ", 5 },
    { "By: ",         " ", 9 },
    { "author_email", " ", 54 },
    { "+#+",          " ", header_wide },
    { "suffix",       " ", header_wide },
  },
  { { "prefix", " ", 3 }, { " ", " ", 53 }, { "+#+", " ", header_wide }, { "suffix", " ", header_wide } },
  {
    { "prefix",     " ", 3 },
    { " ",          " ", 5 },
    { "Created: ",  " ", 14 },
    { "dt",         " ", 34 },
    { "by ",        " ", 37 },
    { "author",     " ", 51 },
    { "#+#    #+#", " ", header_wide },
    { "suffix",     " ", header_wide },
  },
  {
    { "prefix",             " ", 3 },
    { " ",                  " ", 5 },
    { "Updated: ",          " ", 14 },
    { "dt",                 " ", 34 },
    { "by ",                " ", 37 },
    { "author",             " ", 51 },
    { "########   odam.nl", " ", header_wide },
    { "suffix",             " ", header_wide },
  },
  { { "prefix", " ", 3 }, { "suffix", " ", 80 } },
  { { "prefix", " ", 3 }, { "*", "*", header_wide }, { "suffix", " ", header_wide } },
}

--- get the filename of current buffer
--- @param buffnr integer
--- @return string
local function get_filename(buffnr)
  local fullname = vim.api.nvim_buf_get_name(buffnr)
  return vim.fn.fnamemodify(fullname, ":t")
end

--- Check if there is a header
--- on this moment it only check if the first 10 lines are beginning or ending with a comment sign
--- @param comment table
--- @param buffnr integer
--- @return boolean
local function check_header(comment, buffnr)
  if vim.api.nvim_buf_line_count(buffnr) < 9 then
    return false
  end

  local lines = vim.api.nvim_buf_get_lines(buffnr, 0, 9, true)
  local pattern = comment[1] .. ".*" .. comment[2]

  for _, line in ipairs(lines) do
    if string.match(line, pattern) == nil then
      return false
    end
  end

  return true
end

--- right pad a string with a given char and len
--- @param str string
--- @param len integer
--- @param sep string
--- @return unknown
local function right_pad(str, len, sep)
  local str_len = string.len(str)

  if str_len < len then
    return str .. string.rep(sep, len - str_len)
  end

  return str
end

--- create a new line for a header given a line number of the header
--- @param line_nbr integer
--- @param options table
--- @param comment table
--- @param buffnr integer
--- @return string
local function update_header(line_nbr, options, comment, buffnr)
  local line = ""
  local open_comment = comment[1]
  local close_comment = comment[2]
  local open_comment_len = string.len(open_comment)
  local close_comment_len = string.len(close_comment)

  for _, field in ipairs(lines_table[line_nbr]) do
    if field[1] == "prefix" then
      line = right_pad(line .. open_comment, field[3], field[2])
    elseif field[1] == "filename" then
      local filename = get_filename(buffnr)

      if string.len(filename) > field[3] - open_comment_len + 1 then
        filename = string.sub(filename, 1, field[3] - open_comment_len + 1)
      end

      line = right_pad(line .. filename, field[3], field[2])
    elseif field[1] == "author" then
      line = right_pad(line .. options.author, field[3], field[2])
    elseif field[1] == "author_email" then
      local user_field = options.author .. " <" .. options.email .. ">"
      line = right_pad(line .. user_field, field[3], field[2])
    elseif field[1] == "dt" then
      local dt = os.date("%Y/%m/%d %H:%M:%S")
      line = right_pad(line .. dt, field[3], field[2])
    elseif field[1] == "suffix" then
      local suffix_len = close_comment_len

      line = right_pad(line, field[3] - suffix_len, " ")
      if string.len(line) > header_wide - suffix_len then
        line = string.sub(line, 1, header_wide - suffix_len)
      end

      line = line .. close_comment
    else
      line = right_pad(line .. field[1], field[3], field[2])
    end
  end

  return line
end

--- Insert the header if it is not present in the buffer
--- @param options table
--- @param comment table
--- @param buffnr integer
--- @return boolean
header.Insert_header = function(options, comment, buffnr)
  if check_header(comment, buffnr) then
    return false
  end

  for i = 1, #lines_table, 1 do
    vim.api.nvim_buf_set_lines(buffnr, i - 1, i - 1, false, { update_header(i, options, comment, buffnr) })
  end

  vim.api.nvim_buf_set_lines(buffnr, 11, 11, false, { "" })
  return true
end

--- Update header if header is in the buffer
--- @param options table
--- @param comment table
--- @param buffnr integer
--- @return boolean
header.Update_header = function(options, comment, buffnr)
  if not vim.api.nvim_buf_get_option(buffnr, "modified") then
    return false
  end

  if check_header(comment, buffnr) then
    vim.api.nvim_buf_set_lines(buffnr, 3, 4, false, { update_header(4, options, comment, buffnr) }) -- update filename field
    vim.api.nvim_buf_set_lines(buffnr, 8, 9, false, { update_header(9, options, comment, buffnr) }) -- update dt field
    return true
  end

  return false
end

return header
