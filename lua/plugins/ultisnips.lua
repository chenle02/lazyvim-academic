return {
  {
    "SirVer/ultisnips",
    event = "InsertEnter", -- Load Ultisnips on entering insert mode
    config = function()
      -- Set Ultisnips triggers
      vim.g.UltiSnipsExpandTrigger = "<tab>"
      vim.g.UltiSnipsJumpForwardTrigger = "<c-j>"
      vim.g.UltiSnipsJumpBackwardTrigger = "<c-k>"

      -- Configure snippet editing
      vim.g.UltiSnipsEditSplit = "vertical"

      -- Set snippet directories
      vim.g.UltiSnipsSnippetDirectories = { "~/.config/nvim/my_snippets" }

      -- Custom metadata for snippets
      vim.g.snips_author = "Le Chen"
      vim.g.snips_email = "chenle02@gmail.com"
      vim.g.snips_github = "https://github.com/chenle02"

      -- Keybinding for editing snippets
      vim.api.nvim_set_keymap(
        "n",
        "<leader>ee",
        ":UltiSnipsEdit<CR>",
        { noremap = true, silent = true, desc = "Edit UltiSnips" }
      )
    end,
  },
  {
    "honza/vim-snippets", -- Community snippets
    dependencies = { "SirVer/ultisnips" },
  },
  {
    "hrsh7th/nvim-cmp", -- Autocompletion framework
    dependencies = {
      "quangnguyen30192/cmp-nvim-ultisnips", -- Ultisnips integration
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "ultisnips" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },
}
