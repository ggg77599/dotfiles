return {
	{
		"tpope/vim-fugitive",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			-- TODO: using plenary.popup to show
			-- https://dev.to/____marcell/how-to-create-an-ui-menu-in-neovim-2k6a
			-- https://github.com/ThePrimeagen/harpoon/blob/master/lua/harpoon/ui.lua
			vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "git status" })
			vim.keymap.set("n", "<leader>gb", function()
				vim.cmd.Git("blame")
			end, { desc = "git blame" })
			vim.keymap.set("n", "<leader>ga", function()
				vim.cmd.Git("add %")
				print(vim.fn.expand("%"), "added")
			end, { desc = "git add current file" })
			vim.keymap.set("n", "<leader>gd", function()
				vim.cmd("Gvdiffsplit! HEAD")
			end, { desc = "git diff HEAD" })
			vim.keymap.set("n", "<leader>gh", function()
				vim.cmd("silent 0Gclog")
			end, { desc = "show current file's history" })
		end,
	},
}
