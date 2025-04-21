return {
	"mfussenegger/nvim-lint",
	dependencies = {
		"williamboman/mason.nvim",
		"rshkarin/mason-nvim-lint",
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = {
			go = { "golangcilint" },
			terraform = { "tflint" },
			yaml = { "yamllint" },
		}

		require("mason-nvim-lint").setup({
			ensure_installed = {
				"golangci-lint",
				"tflint",
			},
		})

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		-- default linter setting
		-- https://github.com/mfussenegger/nvim-lint/blob/master/lua/lint/linters/yamllint.lua
		require("lint").linters.yamllint.args = {
			"--format",
			"parsable",
			"-d",
			"{extends: default, rules: {line-length: disable}}", -- override default line-length rule
			"-",
		}

		---- golangci-lint breaking changes hotfix
		---- https://github.com/mfussenegger/nvim-lint/issues/760
		--require("lint").linters.golangcilint.args = {
		--	"run",
		--	"--output.json.path=stdout",
		--	"--issues-exit-code=0",
		--	"--show-stats=false",
		--	"--output.text.print-issued-lines=false",
		--	"--output.text.print-linter-name=false",
		--	function()
		--		return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":h")
		--	end,
		--}

		-- Show linters args for the current buffer's file type
		vim.api.nvim_create_user_command("LintInfo", function()
			local filetype = vim.bo.filetype
			local linters = require("lint").linters_by_ft[filetype]

			if linters then
				for _, v in pairs(linters) do
					print("Linters for " .. filetype .. ": " .. v)
					-- FIXME: I can't concatenate other string with unpack
					print(unpack(require("lint").linters[v].args))
				end
			else
				print("No linters configured for filetype: " .. filetype)
			end
		end, {})
	end,
}
