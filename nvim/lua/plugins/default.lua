return {
	{
		"preservim/tagbar",
		config = function()
			vim.keymap.set("n", "<F8>", vim.cmd.TagbarToggle)
		end,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("todo-comments").setup()
		end,
	},
	{
		"tpope/vim-surround",
	},
	{
		-- for vim-surround able to use . to repeat
		"tpope/vim-repeat",
	},
	{
		-- contains search index
		"vim-airline/vim-airline",
	},
}
