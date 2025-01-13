return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-vsnip", -- Vsnip support
    "saadparwaiz1/cmp_luasnip", -- LuaSnip support (optional)
    "quangnguyen30192/cmp-nvim-ultisnips", -- UltiSnips support
    "zbirenbaum/copilot-cmp", -- Copilot support
    "petertriho/cmp-git", -- Git support
    "tamago324/cmp-zsh", -- Zsh completions
    "tzachar/fuzzy.nvim", -- Fuzzy matching
    "tzachar/cmp-fuzzy-path", -- Fuzzy path matching
  },
  opts = function(_, opts)
    local cmp = require("cmp")
    local matcher = require("fuzzy_nvim")

    -- Add your custom sources and configuration
    opts.sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "vsnip" }, -- For vsnip users
      { name = "ultisnips", priority = 900 }, -- For UltiSnips users
      { name = "buffer", option = { keyword_pattern = [[\k\+]] } },
      { name = "path" },
      { name = "spell" },
      { name = "copilot", option = { label = "[copilot]" } },
      { name = "tmux", option = { all_panes = false, label = "[tmux]" } },
      { name = "fuzzy_path" },
      { name = "tags" },
      { name = "zsh", option = { zshrc = true, filetypes = { "zsh", "deoledit" } } },
    })

    opts.mapping = cmp.mapping.preset.insert({
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
    })

    -- Filetype-specific configuration
    cmp.setup.filetype("gitcommit", {
      sources = cmp.config.sources({
        { name = "cmp_git" },
        { name = "buffer" },
      }),
    })

    -- Command-line completion
    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = { { name = "buffer" } },
    })
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
        { name = "cmdline" },
        { name = "fuzzy_path" },
      }),
    })

    -- Snippet configuration
    opts.snippet = {
      expand = function(args)
        -- Uncomment the one you use
        -- vim.fn["vsnip#anonymous"](args.body) -- For vsnip users
        vim.fn["UltiSnips#Anon"](args.body) -- For UltiSnips users
        -- require("luasnip").lsp_expand(args.body) -- For LuaSnip users
      end,
    }

    -- Enable spellchecking
    vim.opt.spell = true
    vim.opt.spelllang = { "en_us" }
  end,
}
