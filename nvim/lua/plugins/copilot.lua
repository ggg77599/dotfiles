return {
	{
		"github/copilot.vim",
		config = function()
			vim.keymap.set("i", "<C-J>", 'copilot#Accept("\\<CR>")', {
				expr = true,
				replace_keycodes = false,
			})
			vim.g.copilot_no_tab_map = true
		end,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
			{ "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		opts = {
			model = "claude-3.7-sonnet",
			-- See Configuration section for options
		},
		-- See Commands section for default commands if you want to lazy load on them
		config = function()
			require("CopilotChat").setup()
			vim.keymap.set("n", "<leader>cc", ":CopilotChatToggle<CR>", { desc = "Toggle chat window" })
		end,
	},
}
