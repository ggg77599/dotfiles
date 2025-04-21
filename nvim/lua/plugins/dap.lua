-- reference:
--      https://www.youtube.com/watch?v=oYzZxi3SSnM
--      https://www.youtube.com/watch?v=lyNfnI-B640
--      https://www.youtube.com/watch?v=MdxOHHutERo
--      https://github.com/tjdevries/config.nvim/blob/master/lua/custom/plugins/dap.lua
--      https://github.com/ThePrimeagen/init.lua/blob/master/lua/theprimeagen/lazy/dap.lua
--      https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#Go
--      https://github.com/mfussenegger/nvim-dap
--      https://github.com/leoluz/nvim-dap-go?tab=readme-ov-file

return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			-- install debugger packages
			"williamboman/mason.nvim",
			"jay-babu/mason-nvim-dap.nvim",

			-- UI
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio", -- nvim-dap-ui's dependency

			-- virtual text
			"theHamsta/nvim-dap-virtual-text",

			-- language
			"leoluz/nvim-dap-go",
		},
		config = function()
			require("mason").setup()
			require("mason-nvim-dap").setup({
				ensure_installed = { "delve" }, -- golang
			})

			require("dapui").setup()
			require("dap-go").setup()
			require("nvim-dap-virtual-text").setup()

			-- open and close the windows automatically
			local dap, dapui = require("dap"), require("dapui")
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			-- key maps
			vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
			vim.keymap.set("n", "<C-1>", dap.continue, { desc = "Debug: Continue" })
			vim.keymap.set("n", "<C-2>", dap.step_into, { desc = "Debug: Step Into" })
			vim.keymap.set("n", "<C-3>", dap.step_over, { desc = "Debug: Step Over" })
			vim.keymap.set("n", "<C-4>", dap.step_out, { desc = "Debug: Step Out" })
			vim.keymap.set("n", "<leader>dc", dap.run_to_cursor, { desc = "Debug: Run To Cursor" })
			vim.keymap.set("n", "<leader>dt", require("dap-go").debug_test, { desc = "Debug: Test" })
			vim.keymap.set("n", "<leader>du", require("dapui").toggle, { desc = "Debug: Show UI" })
		end,
	},
}
