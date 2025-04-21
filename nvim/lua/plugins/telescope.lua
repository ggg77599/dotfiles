return {
	-- FIXME: rename file to fuzzysearch.lua
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
		vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
		vim.keymap.set("n", "<leader>fm", builtin.keymaps, {})

		-- :h i_CTRL-R for more detail, CTRL-R 0 is the register 0
		vim.keymap.set("v", "<leader>fg", "y<ESC>:Telescope live_grep default_text=<c-r>0<CR>", {})

		-- TODO: grep from current cursor variable
	end,
}
