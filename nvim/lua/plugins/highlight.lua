return {
	-- for highlight keywords
	{
		"lfv89/vim-interestingwords",
		init = function()
			vim.g.interestingWordsDefaultMappings = 0
		end,
		config = function()
			vim.keymap.set("n", "<leader>k", ":call InterestingWords('n')<CR>")
			vim.keymap.set("v", "<leader>k", ":call InterestingWords('v')<CR>")
			vim.keymap.set("n", "<leader>K", ":call UncolorAllWords()<CR>")
		end,
	},
}
