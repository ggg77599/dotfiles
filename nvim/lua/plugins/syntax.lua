return {
	{
		"mfukar/robotframework-vim", -- python robotframework
		dependencies = {
			{ "sheerun/vim-polyglot" }, -- to make it loaded after vim-polyglot
		},
	},
	{
		"sheerun/vim-polyglot", -- A collection of language packs for Vim
		init = function()
			-- disalbe modula2 to make filetype gomod work
			vim.g.polyglot_disabled = { "modula2" }
		end,
		config = function()
			-- set file type for *.json.gotmpl
			vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
				pattern = "*.json.gotmpl",
				command = "set filetype=json.gotexttmpl",
				once = true,
			})
		end,
	},
}
