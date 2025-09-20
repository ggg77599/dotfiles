function ColorMyPencils(color)
	-- color = color or "tokyonight"
	color = color or "nightfly"
	-- color = color or "kanagawa-wave"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
	-- {
	-- 	"folke/tokyonight.nvim",
	-- 	config = function()
	-- 		ColorMyPencils()
	-- 	end,
	-- },
	{
		"bluz71/vim-nightfly-colors",
		config = function()
			ColorMyPencils()
		end,
	},
	-- {
	-- 	"rebelot/kanagawa.nvim",
	-- 	config = function()
	-- 		ColorMyPencils()
	-- 		-- require("kanagawa").load("wave")
	-- 	end,
	-- },
}
