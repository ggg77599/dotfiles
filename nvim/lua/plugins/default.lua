return {
  {
    "preservim/tagbar",
    config = function()
      vim.keymap.set("n", "<F8>", vim.cmd.TagbarToggle)
    end,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("todo-comments").setup()
    end,
  },
  {
    "tpope/vim-surround",
  },
  {
    -- for vim-surround able to use . to repeat
    "tpope/vim-repeat",
  },
  {
    -- contains search index
    "vim-airline/vim-airline",
  },
  {
    -- press enter to confirm, Esc to cancel
    "saecki/live-rename.nvim",
    config = function()
      local live_rename = require("live-rename")

      -- start in insert mode and jump to the end of the word
      vim.keymap.set("n", "<leader>r", live_rename.map({ insert = true }), { desc = "LSP rename" })
      -- start in insert mode and clear all the text
      vim.keymap.set("n", "<leader>R", live_rename.map({ text = "", insert = true }), { desc = "LSP rename" })
    end,
  },
}
