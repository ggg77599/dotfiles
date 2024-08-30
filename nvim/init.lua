
-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- source my vimrc config before I have time to convert all the setting to lua
vim.cmd.source("~/.vimrc")

-- enable package manage
require("config.lazy")


-- other setting just for neovim
vim.opt.guicursor = ""  -- make insert mode cursor in block shape
