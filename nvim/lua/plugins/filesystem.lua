return {
	{
		"stevearc/oil.nvim", -- edit file system like a buffer
		-- dependencies = { { "echasnovski/mini.icons", opts = {} } }, -- add icons
		config = function()
			require("oil").setup({
				view_options = {
					show_hidden = true,
				},
			})

			-- using `-` to open parent directory in Oil view

			-- overwrite default mappings
			vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open parent directory" })
		end,
	},
}
