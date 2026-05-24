-- return {}
local parsers = {
	"vimdoc",
	"c",
	"lua",
	"rust",
	"bash",
	"go",
	"gotmpl",
	"helm",
	"yaml",
	"markdown",
	"markdown_inline",
}

return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local ts = require("nvim-treesitter")
		ts.install(parsers)

		vim.api.nvim_create_autocmd("FileType", {
			pattern = parsers,
			callback = function(args)
				local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
				if lang and not vim.tbl_contains(ts.get_installed(), lang) then
					ts.install({ lang }):await(function()
						pcall(vim.treesitter.start, args.buf)
					end)
				else
					pcall(vim.treesitter.start, args.buf)
				end
			end,
		})
	end,
}
