return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"fredrikaverpil/neotest-golang",
		},
		config = function()
			-- local neotest_golang_opts = {}
			-- for coverage setting
			-- reference: https://github.com/fredrikaverpil/neotest-golang/blob/main/docs/recipes.md#coverage
			local neotest_golang_opts = { -- Specify configuration
				runner = "go",
				go_test_args = {
					"-v",
					"-race", -- set this will detect race condition
					"-count=1",
					"-coverprofile=" .. vim.fn.getcwd() .. "/coverage.out",
				},
			}
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
				vim.api.nvim_command("write")
				require("neotest").run.run()
			end, { desc = "Run nearest test" })
			vim.keymap.set("n", "<leader>ts", function()
				require("neotest").summary.toggle()
			end, { desc = "Toggle test summary" })
			vim.keymap.set("n", "<leader>ta", function()
				require("neotest").run.run(vim.fn.expand("%"))
			end, { desc = "Run all tests" })
			vim.keymap.set("n", "<leader>to", function()
				require("neotest").output.open({ enter = true })
			end, { desc = "Run test output" })
		end,
	},
	{
		"andythigpen/nvim-coverage",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("coverage").setup({
				auto_reload = true,
			})

			local coverage_toggle = false -- when toggle on, we should load coverage file

			vim.keymap.set("n", "<leader>tc", function()
				local c = require("coverage")

				if not coverage_toggle then
					c.load()
					coverage_toggle = true
					c.show()
				else
					c.hide()
					coverage_toggle = false
				end
			end, { desc = "Toggle Coverage" })
		end,
	},
}
