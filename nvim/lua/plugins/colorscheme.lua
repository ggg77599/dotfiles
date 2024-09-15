function ColorMyPencils(color)
	-- color = color or "tokyonight"
	color = color or "nightfly"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
	--{
	--    "rose-pine/neovim",
	--    name = "rose-pine",
	--    config = function()
	--        ColorMyPencils()
	--        vim.o.background = "dark"
	--        vim.cmd.colorscheme "rose-pine"
	--    end,
	--},
	-- {
	--     "folke/tokyonight.nvim",
	--     config = function()
	--         require("tokyonight").setup({
	--             -- your configuration comes here
	--             -- or leave it empty to use the default settings
	--             style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
	--             transparent = true, -- Enable this to disable setting the background color
	--             terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
	--             styles = {
	--                 -- Style to be applied to different syntax groups
	--                 -- Value is any valid attr-list value for `:help nvim_set_hl`
	--                 comments = { italic = false, fg="#bf9c0d" },
	--                 keywords = { italic = false },
	--                 -- Background styles. Can be "dark", "transparent" or "normal"
	--                 sidebars = "dark", -- style for sidebars, see below
	--                 floats = "dark", -- style for floating windows
	--             },
	--         })
	--         vim.o.background = "dark"
	--         vim.cmd.colorscheme "tokyonight"
	--     end
	-- },
	--{ "ellisonleao/gruvbox.nvim",
	--    config = function()
	--        vim.o.background = "dark"
	--        vim.cmd.colorscheme "gruvbox"
	--    end,
	--},
	-- {
	--     "rakr/vim-one",
	--     lazy = false, -- make sure we load this during startup if it is your main colorscheme
	--     priority = 1000,
	--     config = function()
	--         vim.o.background = "dark"
	--         vim.cmd.colorscheme "one"
	--     end,
	-- },
	-- {
	--     "joshdick/onedark.vim",
	--     lazy = false, -- make sure we load this during startup if it is your main colorscheme
	--     priority = 1000,
	--     config = function()
	--         -- vim.o.background = "dark"
	--         vim.cmd.colorscheme "onedark"
	--     end,
	-- },

	--{ "nlknguyen/papercolor-theme",
	--    lazy = false, -- make sure we load this during startup if it is your main colorscheme
	--    priority = 1000,
	--	config = function()
	--   		-- vim.o.background = "dark"
	--   		vim.cmd.colorscheme "PaperColor"
	--	end,
	--}
	--{
	--     "amberlehmann/candyland.nvim",
	--    config = function()
	--    	vim.o.background = "dark"
	--    	vim.cmd.colorscheme "candyland"
	--    end,
	-- }
	--{ "ellisonleao/gruvbox.nvim",
	--    config = function()
	--    	vim.o.background = "dark"
	--    	vim.cmd.colorscheme "gruvbox"
	--    end,
	--}
	-- for colorschema
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
}
