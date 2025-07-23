return {
	{
		"MattesGroeger/vim-bookmarks",
		config = function()
			vim.g.bookmark_no_default_key_mappings = 1
			vim.g.bookmark_save_per_working_dir = 1
			vim.g.bookmark_auto_save = 1

			vim.keymap.set("n", "mm", ":BookmarkToggle<CR>") -- add or remove bookmark at current line
			vim.keymap.set("n", "mn", ":BookmarkNext<CR>") -- jump to next mark in local buffer
			vim.keymap.set("n", "mp", ":BookmarkPrev<CR>") -- jump to previous mark in local buffer
			vim.keymap.set("n", "ml", ":BookmarkShowAll<CR>") -- show marked file list in quickfix window
			vim.keymap.set("n", "mx", ":BookmarkClearAll<CR>") -- removes all bookmarks
		end,
	},
}
