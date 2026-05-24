-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- enable neovim to read project level configuration `.nvim.lua`,
-- I store all project level config in the `nvim/lua/local`
-- TODO: rename the folder to better name
vim.opt.exrc = true

-- source my vimrc config before I have time to convert all the setting to lua
vim.cmd.source("~/.vimrc")

-- enable package manage
require("config.lazy")

-- other setting just for neovim
vim.opt.guicursor = "" -- make insert mode cursor in block shape
vim.opt.hlsearch = true

vim.opt.laststatus = 3 -- set global status line
-- highlight WinSeparator guibg=None
vim.api.nvim_set_hl(0, "WinSeparator", { bg = "None" })

-- https://github.com/neovim/neovim/discussions/39706
vim.diagnostic.config({
	jump = {
		on_jump = function(_, bufnr)
			vim.diagnostic.open_float({
				bufnr = bufnr,
				scope = "cursor",
				focus = false,
			})
		end,
	},
})
-- Next diagnostic
vim.keymap.set("n", "<F8>", function()
	vim.diagnostic.jump({ count = 1 })
end, { desc = "Next Diagnostic" })
-- Previous diagnostic
vim.keymap.set("n", "<F9>", function()
	vim.diagnostic.jump({ count = -1 })
end, { desc = "Previous Diagnostic" })
