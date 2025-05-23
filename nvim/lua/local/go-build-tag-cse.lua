-- setup lsp server
require("lspconfig").gopls.setup({
	settings = {
		["gopls"] = {
			buildFlags = { "-tags=cse" },
		},
	},
})

-- setup test
-- https://github.com/fredrikaverpil/neotest-golang/blob/main/docs/recipes.md#using-build-tags
local neotest_golang_opts = { -- Specify configuration
	runner = "go",
	go_test_args = {
		"-v",
		"-tags=cse",
		"-race",
		"-count=1",
		"-coverprofile=" .. vim.fn.getcwd() .. "/coverage.out",
	},
	go_list_args = { "-tags=cse" },
	dap_go_opts = {
		delve = {
			build_flags = { "-tags=cse" },
		},
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

-- setup dap
-- https://github.com/leoluz/nvim-dap-go/blob/main/lua/dap-go.lua
require("dap-go").test_buildflags = "-tags=cse"

-- linter
local args = require("lint").linters.golangcilint.args
table.insert(args, 2, "--build-tags=cse")
require("lint").linters.golangcilint.args = args
