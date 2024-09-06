return {
	{
		"yanskun/gotests.nvim",
		dependencies = {
			{ "williamboman/mason.nvim" },
		},
		ft = "go",
		config = function()
			require("gotests").setup()
		end,
	},
	-- {
	-- 	"fatih/vim-go",
	-- 	lazy = true,
	-- 	ft = "go",
	-- },
}
