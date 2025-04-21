return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"fredrikaverpil/neotest-golang",
	},
	config = function()
		local neotest_golang_opts = {}
		require("neotest").setup({
			adapters = {
				require("neotest-golang")(neotest_golang_opts),
			},
			-- not showing error quickfix window after running tests
			quickfix = {
				enabled = false,
				open = false,
			},
		})

		vim.keymap.set("n", "<leader>tt", function()
			require("neotest").run.run()
		end, { desc = "Run nearest test" })
		vim.keymap.set("n", "<leader>ts", function()
			require("neotest").summary.toggle()
		end, { desc = "toggle test summary" })
		vim.keymap.set("n", "<leader>ta", function()
			require("neotest").run.run(vim.fn.expand("%"))
		end, { desc = "Run all tests" })
		vim.keymap.set("n", "<leader>to", function()
			require("neotest").output.open({ enter = true })
		end, { desc = "Run test output" })
	end,
}
