-- return {
--     "neovim/nvim-lspconfig",
--     dependencies = {
--         "williamboman/mason.nvim",
--         "williamboman/mason-lspconfig.nvim",
--
--         "hrsh7th/cmp-nvim-lsp",
--         "hrsh7th/cmp-buffer",
--         "hrsh7th/cmp-path",
--         "hrsh7th/cmp-cmdline",
--         "hrsh7th/nvim-cmp",
--         "L3MON4D3/LuaSnip",
--         "saadparwaiz1/cmp_luasnip",
--         "j-hui/fidget.nvim",
--     },
--     conifg = function()
--         require("mason").setup()
--         require("mason-lspconfig").setup()
--     end
-- }

return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v4.x',
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },             -- Required
      { 'williamboman/mason.nvim' },           -- Optional
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },     -- Required
      { 'hrsh7th/cmp-nvim-lsp' }, -- Required
      { 'L3MON4D3/LuaSnip' },     -- Required
    },
    config = function()
      -- lsp setup
      local lsp = require('lsp-zero').preset({})

      lsp.on_attach(function(client, bufnr)
        -- see :help lsp-zero-keybindings
        -- to learn the available actions
        lsp.default_keymaps({
          buffer = bufnr,
          omit = { 'gs', 'K' }, -- disable some default keymaps
        })
      end)

      lsp.ensure_installed({
        -- Replace these with whatever servers you want to install
        'lua_ls',
        'gopls',
        'rust_analyzer',
        'pyright',
      })

      lsp.format_on_save({
        format_opts = {
          async = false,
          timeout_ms = 10000,
        },
        servers = {
          ['lua_ls'] = { 'lua' },
          ['rust_analyzer'] = { 'rust' },
        }
      })


      -- require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
      lsp.setup()

      -- select candidate by tab and press enter to confirm
      -- https://github.com/hrsh7th/nvim-cmp/discussions/1498
      local cmp = require("cmp")
      cmp.setup({
        mapping = {
          -- If nothing is selected (including preselections) add a newline as usual.
          -- If something has explicitly been selected by the user, select it.
          ["<Enter>"] = function(fallback)
            -- Don't block <CR> if signature help is active
            -- https://github.com/hrsh7th/cmp-nvim-lsp-signature-help/issues/13
            if not cmp.visible() or not cmp.get_selected_entry() or cmp.get_selected_entry().source.name == 'nvim_lsp_signature_help' then
              fallback()
            else
              cmp.confirm({
                -- Replace word if completing in the middle of a word
                -- https://github.com/hrsh7th/nvim-cmp/issues/664
                behavior = cmp.ConfirmBehavior.Replace,
                -- Don't select first item on CR if nothing was selected
                select = false,
              })
            end
          end,
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              local entries = cmp.get_entries()
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })

              if #entries == 1 then
                cmp.confirm()
              end
            else
              fallback()
            end
          end, { "i", "s" }),
        }
      })
    end
  }
}