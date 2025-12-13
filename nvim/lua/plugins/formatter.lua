-- reference:
-- https://andrewcourter.substack.com/p/configure-linting-formatting-and
-- https://github.com/stevearc/conform.nvim/issues/104
-- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim

local function find_golangci_config()
	local root = vim.fs.root(0, { ".golangci.yaml", ".golangci.yml" })
	if not root then
		return nil
	end

	local path_yaml = root .. "/.golangci.yaml"
	local path_yml = root .. "/.golangci.yml"

	local file = vim.fn.filereadable(path_yaml) == 1 and path_yaml
		or (vim.fn.filereadable(path_yml) == 1 and path_yml or nil)

	return file
end

local function read_yaml(path)
	-- Use yq to convert YAML to JSON, then parse with vim.json.decode
	local cmd = string.format("yq -o json '%s'", path)
	local output = vim.fn.system(cmd)

	-- Check if command failed
	if vim.v.shell_error ~= 0 then
		vim.notify("Failed to parse YAML with yq: " .. output, vim.log.levels.ERROR)
		return nil
	end

	return vim.json.decode(output)
end

local function get_gci_settings()
	local cfg_path = find_golangci_config()
	if not cfg_path then
		return nil
	end

	local yaml = read_yaml(cfg_path)

	if
		not yaml
		or not yaml["formatters"]
		or not yaml["formatters"]["settings"]
		or not yaml["formatters"]["settings"]["gci"]
	then
		return nil
	end

	return yaml["formatters"]["settings"]["gci"]
end

local function build_gci_args(settings)
	local args = { "write" }

	-- Add sections
	if settings.sections then
		for _, section in ipairs(settings.sections) do
			table.insert(args, "--section")
			table.insert(args, section)
		end
	end

	-- Add custom-order flag if enabled
	if settings["custom-order"] then
		table.insert(args, "--custom-order")
	end

	-- Add skip-generated (always on)
	table.insert(args, "--skip-generated")

	-- Add filename placeholder
	table.insert(args, "$FILENAME")

	return args
end

return {
	"stevearc/conform.nvim",
	dependencies = {
		"williamboman/mason.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local timeout = 3500
		local conform = require("conform")

		require("mason-tool-installer").setup({
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
				"tombi", -- toml
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

		-- Configure gci based on .golangci.yml settings
		local gci_settings = get_gci_settings()
		if gci_settings then
			require("conform").formatters.gci = {
				args = build_gci_args(gci_settings),
			}
		end

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
