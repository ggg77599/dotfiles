return {
	{
		"neovim/nvim-lspconfig", -- Required
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",

			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/nvim-cmp",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"j-hui/fidget.nvim",
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = function(event)
					local opts = { buffer = event.buf }

					-- these will be buffer-local keybindings
					-- because they only work if you have an active language server

					vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
					vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
					vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
					vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
					vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)

					vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
					vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
					vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
					vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)

					-- renam by saecki/live-rename.nvim
					-- vim.keymap.set('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
				end,
			})

			local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

			require("mason").setup({})
			require("mason-lspconfig").setup({
				-- language servers list
				ensure_installed = {
					-- lsp servers
					"bashls", -- bash
					"gopls", -- golang
					"lua_ls", -- lua
					"pylsp", -- python, python-lsp-server
					"rust_analyzer", -- rust
					"pbls", -- protobuf
					"helm_ls", -- helm
					"jsonls", -- json
					"terraformls", -- terraform
					"yamlls", -- yaml
					-- "robotframework_ls", -- robotframework

					-- dap
					-- "delve",
				},
				handlers = {
					function(server_name)
						require("lspconfig")[server_name].setup({
							capabilities = lsp_capabilities,
						})
					end,

					-- customized language server
					-- https://lsp-zero.netlify.app/blog/you-might-not-need-lsp-zero
					lua_ls = function()
						require("lspconfig").lua_ls.setup({
							capabilities = lsp_capabilities,
							---
							-- This is where you place your custom config
							--
							-- make lua_ls only show LuaJIT
							settings = {
								Lua = {
									runtime = {
										version = "LuaJIT",
									},
									diagnostics = {
										globals = { "vim" },
									},
									workspace = {
										library = {
											vim.env.VIMRUNTIME,
										},
									},
								},
							},
						})
					end,

					-- setup python language server ruff
					-- TODO: run the following commands to install the 3rd packages
					-- :PylspInstall python-lsp-black
					-- :PylspInstall pyls-isort
					pylsp = function()
						require("lspconfig").pylsp.setup({
							capabilities = lsp_capabilities,
							settings = {
								pylsp = {
									plugins = {
										pycodestyle = {
											enabled = false,
										},
										black = {
											enabled = true,
										},
									},
								},
							},
						})
					end,

					-- TODO: shfmt, shellcheck
				},
			})

			local cmp = require("cmp")
			local luasnip = require("luasnip")

			cmp.setup({
				sources = {
					{ name = "luasnip" }, -- For luasnip users.
					{ name = "nvim_lsp" },
					{ name = "path" }, -- path completion
				},
				{
					{ name = "buffer" }, -- buffer completion
				},
				mapping = cmp.mapping.preset.insert({
					-- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
					["<CR>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							if luasnip.expandable() then
								luasnip.expand()
							else
								cmp.confirm({
									select = true,
								})
							end
						else
							fallback()
						end
					end),

					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.locally_jumpable(1) then
							luasnip.jump(1)
						else
							fallback()
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
			})
		end,
	},
}
