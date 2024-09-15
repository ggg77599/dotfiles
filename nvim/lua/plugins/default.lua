return {
	"preservim/tagbar",
	config = function()
		vim.keymap.set("n", "<F8>", vim.cmd.TagbarToggle)
	end,
}
