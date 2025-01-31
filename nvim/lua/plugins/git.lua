return {
	{
		"tpope/vim-fugitive",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			-- TODO: using plenary.popup to show
			-- https://dev.to/____marcell/how-to-create-an-ui-menu-in-neovim-2k6a
			-- https://github.com/ThePrimeagen/harpoon/blob/master/lua/harpoon/ui.lua
			vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
			vim.keymap.set("n", "<leader>ga", function()
				vim.cmd.Git("add %")
				print(vim.fn.expand("%"), "added")
			end)
			-- TODO: diff with HEAD
			-- vim.keymap.set("n", "<leader>gd", "<cmd> Git diff %<CR>")
		end,
	},
}
