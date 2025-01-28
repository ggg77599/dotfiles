-- reference:
--      https://www.youtube.com/watch?v=oYzZxi3SSnM
--      https://www.youtube.com/watch?v=lyNfnI-B640

return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"williamboman/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",
	},
	config = function()
		require("mason").setup()
		require("mason-nvim-dap").setup({
			ensure_installed = { "delve" },
		})
	end,
	lazy = true,
}
