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
	"markdown",
	"markdown_inline",
}

return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	opts = {
		ensure_installed = parsers,
		highlight = { enable = true },
	},
	init = function()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = parsers,
			callback = function(args)
				vim.treesitter.start(args.buf)
			end,
		})
	end,
}
