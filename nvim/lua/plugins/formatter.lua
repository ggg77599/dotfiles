-- reference:
-- https://andrewcourter.substack.com/p/configure-linting-formatting-and
-- https://github.com/stevearc/conform.nvim/issues/104
-- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
--
return {
	"stevearc/conform.nvim",
	dependencies = {
		"williamboman/mason.nvim",
		"zapling/mason-conform.nvim",
	},
	config = function()
		local timeout = 3500
		local conform = require("conform")

		require("mason-conform").setup({
			ensure_installed = {
				"clang-format",
				"gofumpt", -- golang format
				"goimports", -- golang auto import
				"gotests", -- golang create tests
				"stylua", -- lua
				"yamlfmt", -- yaml
				"shfmt", -- shell
				"shellharden", -- shell
			},
		})

		conform.setup({
			formatters_by_ft = {
				json = { "clang-format" },
				proto = { "clang-format" },
				go = { "gofumpt", "goimports" },
				lua = { "stylua" },
				yaml = { "yamlfmt" },
				-- shellharden might break some scripts, which is not secure enough
				-- it requires all the command output or variable to be quoted, which
				-- will break some for loop.
				-- sh = { "shellharden", "shfmt" },
				sh = { "shfmt" },
				robot = { "robotidy" }, -- custom formatter
			},
			-- custom formatter
			-- https://github.com/stevearc/conform.nvim?tab=readme-ov-file#customizing-formatters
			formatters = {
				robotidy = {
					command = "robotidy",
					args = { "$FILENAME" },
					stdin = false,
				},
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>=", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = timeout,
			})
		end, { desc = "Format file or range (in visual mode)" })

		vim.keymap.set("c", "W", "noautocmd w", {
			desc = "Save without formating the file",
		})

		conform.setup({
			format_on_save = {
				-- These options will be passed to conform.format()
				timeout_ms = timeout,
				lsp_format = "fallback",
			},
		})
	end,
}
