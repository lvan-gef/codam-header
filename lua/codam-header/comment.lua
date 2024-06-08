local M = {}

local comments_map = {
	hashes = { "# ", " #" },
	slashes = { "/* ", " */" },
	semicolon = { "; ", " ;" },
	semicolons = { ";; ", " ;;" },
	parens = { "(* ", " *)" },
	dashes = { "-- ", " --" },
	percents = { "%% ", " %%" },
	troffcom = { '.\\"', '"\\.' },
	dquote = { '" ', ' "' },
}

local program_map = {
	hashes = {
		"coffeescript",
		"dockerfile",
		"makefile",
		"perl",
		"perl6",
		"plaintext",
		"powershell",
		"python",
		"r",
		"ruby",
		"shellscript",
		"sql",
		"yaml",
		"sh",
	},
	slashes = {
		"c",
		"cpp",
		"css",
		"go",
		"groovy",
		"jade",
		"java",
		"javascript",
		"javascriptreact",
		"less",
		"objective-c",
		"php",
		"rust",
		"scss",
		"swift",
		"typescript",
		"typescriptreact",
		"xsl",
	},
	semicolon = { "asm" },
	semicolons = { "ini" },
	parens = { "fsharp", "ocaml" },
	dashes = { "haskell", "lua" },
	percents = { "latex" },
	troff = { "troffcom" },
	dquote = { "vim" },
}

--- Get the comment sign for the language
--- @param buffnr integer
--- @return table | nil
function M.Get_comment(buffnr)
	local lang = vim.api.nvim_buf_get_option(buffnr, "filetype")
	lang = string.lower(lang)

	for program, elements in pairs(program_map) do
		for _, elem in pairs(elements) do
			if elem == lang then
				return comments_map[program]
			end
		end
	end

	return nil
end

return M
