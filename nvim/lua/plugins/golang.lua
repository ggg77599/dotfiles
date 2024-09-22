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
	{
    -- for unit test coverage
		"arp242/gopher.vim",
	},
	-- {
	-- 	"fatih/vim-go",
	-- 	lazy = true,
	-- 	ft = "go",
	-- },
}
