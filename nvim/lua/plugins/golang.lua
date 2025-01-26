return {
  {
    "yanskun/gotests.nvim",
    dependencies = {
      { "williamboman/mason.nvim" },
    },
    ft = "go",
    config = function()
      require("gotests").setup()
    end,
  },
  {
    -- for unit test coverage
    "arp242/gopher.vim",
    lazy = true,
  },
  -- {
  -- 	"fatih/vim-go",
  -- 	lazy = true,
  -- 	ft = "go",
  -- },
}
