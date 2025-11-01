return {
	{
		"preservim/tagbar",
		config = function()
			vim.keymap.set("n", "<F8>", vim.cmd.TagbarToggle)
			vim.g.tagbar_sort = 0 -- disable sorting, order by source file
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
	{
		"google/vim-searchindex",
	},
	-- {
	-- 	"nvim-lualine/lualine.nvim",
	-- 	-- dependencies = { "nvim-tree/nvim-web-devicons" },
	-- 	config = function()
	-- 		require("lualine").setup()
	-- 	end,
	-- },
	-- {
	-- 	-- press enter to confirm, Esc to cancel
	-- 	-- this package will rename variable to a lowercase variable then replace
	-- 	it again, it will make Golang throw an un-exported error
	-- 	"saecki/live-rename.nvim",
	-- 	config = function()
	-- 		local live_rename = require("live-rename")

	-- 		-- start in insert mode and jump to the end of the word
	-- 		vim.keymap.set("n", "<leader>r", live_rename.map({ insert = true }), { desc = "LSP rename", silent = true })
	-- 		-- start in insert mode and clear all the text
	-- 		vim.keymap.set(
	-- 			"n",
	-- 			"<leader>R",
	-- 			live_rename.map({ text = "", insert = true }),
	-- 			{ desc = "LSP rename", silent = true }
	-- 		)
	-- 	end,
	-- },
	{
		"smjonas/inc-rename.nvim",
		config = function()
			require("inc_rename").setup()

			vim.keymap.set("n", "<leader>r", function()
				return ":IncRename " .. vim.fn.expand("<cword>")
			end, { expr = true })
		end,
	},
	{
		"szw/vim-maximizer",
		config = function()
			vim.keymap.set("n", "<leader>m", function()
				vim.cmd("MaximizerToggle")
			end, {})
		end,
	},
	{
		"haodarohh/bufcomm.vim",
	},
}
