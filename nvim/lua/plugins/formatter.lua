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
			ensure_installed = { -- not work !?
				"clang-format",
				"gofumpt", -- golang format
				"goimports", -- golang auto import
				"gotests", -- golang create tests
				"gci", -- golang import order
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
				go = { "gofumpt", "goimports", "gci" },
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

		-- overwrite formatter parameter
		require("conform").formatters.shfmt = {
			prepend_args = { "-sr" },
		}
		require("conform").formatters.yamlfmt = {
			prepend_args = { "-formatter", "pad_line_comments=2" },
		}
		require("conform").formatters.gci = {
			-- copy the setting from the .golangci.yml
			args = {
				"write",
				"--section",
				"standard",
				"--section",
				"default",
				"--custom-order",
				"--skip-generated",
				"$FILENAME",
			},
		}

		-- keymaps
		vim.keymap.set({ "n", "v" }, "<leader>=", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = timeout,
			})
		end, { desc = "Format file or range (in visual mode)" })

		-- W command to save without formatting
		-- To prevent affecting the search, we don't use the keymap.set
		-- https://stackoverflow.com/questions/30836269/how-to-map-a-key-in-command-line-mode-but-not-in-search-mode
		vim.api.nvim_create_user_command("W", function()
			-- command! -nargs=* -complete=file -range=% -bang -bar W noautocmd w
			-- TODO: currently, I don't need other parameter, but save it for future
			-- reference
			vim.cmd("noautocmd w")
		end, {})

		conform.setup({
			format_on_save = {
				-- These options will be passed to conform.format()
				timeout_ms = timeout,
				lsp_format = "fallback",
			},
		})
	end,
}
