-- reference: https://andrewcourter.substack.com/p/configure-linting-formatting-and
return {
	"stevearc/conform.nvim",
	opts = {},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local timeout = 1500
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				json = { "clang-format" },
				proto = { "clang-format" },
				go = { "gofumpt", "goimports" },
				lua = { "stylua" },
				yaml = { "prettier" },
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>l", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = timeout,
			})
		end, { desc = "Format file or range (in visual mode)" })

		conform.setup({
			format_on_save = {
				-- These options will be passed to conform.format()
				timeout_ms = timeout,
				lsp_format = "fallback",
			},
		})
	end,
}
