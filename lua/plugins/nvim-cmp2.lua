vim.api.nvim_command("set completeopt=menu,menuone,noselect")

return {
  {
    "hrsh7th/nvim-cmp",

    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "tzachar/fuzzy.nvim",
      "tzachar/cmp-fuzzy-path", -- Optional fuzzy path source
      "hrsh7th/cmp-omni",
      "hrsh7th/cmp-spell",
      "github/copilot.vim",
      -- for vimtex
      "micangl/cmp-vimtex",
      -- For vsnip users.
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",
      "aspeddro/cmp-pandoc.nvim",
    },

    opts = function(_, opts)
      local cmp = require("cmp")
      local matcher = require("fuzzy_nvim")

      matcher:filter("abc", { "aabbcc", "123", "a1b2c" })

      opts.snippet = {
        expand = function(args)
          vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users
          -- vim.fn["vsnip#anonymous"](args.body) -- Uncomment for `vsnip` users
        end,
      }

      opts.mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      })

      opts.sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "ultisnips", priority = 900 },
        { name = "buffer", option = { keyword_pattern = [[\k\+]] } },
        { name = "path" },
        { name = "tags", keyword_length = 2 },
        { name = "fuzzy_path" },
        { name = "omni" },
        { name = "vimtex" },
        { name = "spell" },
        { name = "cmp_pandoc" },
        { name = "copilot", option = { label = "[copilot]" } },
        { name = "tmux", option = { all_panes = false, label = "[tmux]" } },
      })

      -- opts.window = {
      --   completion = cmp.config.window.bordered(),
      --   documentation = cmp.config.window.bordered(),
      -- }
      --

      window = {
        documentation = {
          border = "rounded", -- Style of the border
          winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder", -- Highlighting
          max_width = 80, -- Maximum width of the documentation window
          max_height = 20, -- Maximum height of the documentation window
        },
      }

      -- Set up custom formatting for completion items
      opts.formatting = {
        format = function(entry, vim_item)
          vim_item.menu = ({
            nvim_lsp = "[LSP]",
            ultisnips = "[Snippets]",
            buffer = "[Buffer]",
            path = "[Path]",
            tags = "[Tags]",
            fuzzy_path = "[FuzzyPath]",
            omni = "[Omni]",
            vimtex = "[VimTex]",
            spell = "[Spell]",
            copilot = "[Copilot]",
            tmux = "[Tmux]",
          })[entry.source.name]
          return vim_item
        end,
      }
      -- Additional configurations for specific filetypes
      cmp.setup.filetype("gitcommit", {
        { name = "nvim_lsp" },
        { name = "vsnip" }, -- For vsnip users.
        -- { name = 'luasnip' }, -- For luasnip users.
        { name = "ultisnips", priority = 900 }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
        { name = "buffer", option = {
          keyword_pattern = [[\k\+]],
        } },
        { name = "path" },
        { name = "omni" },
        -- { name = 'cmdline' },
        -- { name = 'zsh' },
        -- { name = 'calc' },
        { name = "spell" },
        { name = "copilot", option = {
          label = "[copilot]",
        } },
        {
          name = "tmux",
          option = {
            all_panes = false,
            label = "[tmux]",
            trigger_characters = { "." },
            trigger_characters_ft = {},
            -- { filetype = { '.' }, }
          },
        },
        -- { name = 'fuzzy_path' },
      })

      -- Use buffer source for `/`
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      -- Use cmdline & path source for `:`
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
          { name = "cmdline" },
          { name = "fuzzy_path" },
        }),
      })

      -- Set up the Omni function for LaTeX files
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "tex",
        callback = function()
          vim.bo.omnifunc = "vimtex#complete#omnifunc"
        end,
      })

      -- Setup enhanced LSP capabilities
      local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
      local lspconfig = require("lspconfig")
      -- Example LSP server configurations
      lspconfig.lua_ls.setup({ capabilities = capabilities })
      lspconfig.pyright.setup({ capabilities = capabilities })
      lspconfig.tsserver.setup({ capabilities = capabilities })
    end,
  },
  -- {
  --   "micangl/cmp-vimtex",
  --   dependencies = {
  --     "hrsh7th/nvim-cmp",
  --     "lervag/vimtex",
  --   },
  --   config = function()
  --     require("cmp_vimtex").setup({
  --       additional_information = {
  --         info_in_menu = true,
  --         info_in_window = true,
  --         info_max_length = 60,
  --         match_against_info = true,
  --         origin_in_menu = true,
  --         symbols_in_menu = true,
  --         bib_highlighting = true,
  --         highlight_colors = {
  --           colon_group = "Normal",
  --           default_key_group = "PreProc",
  --           default_value_group = "String",
  --           important_key_group = "Normal",
  --           important_value_group = "Identifier",
  --         },
  --         highlight_links = {
  --           Annote = "Default",
  --         },
  --       },
  --       bibtex_parser = {
  --         enabled = true,
  --       },
  --       search = {
  --         browser = "xdg-open",
  --         default = "google_scholar",
  --         search_engines = {
  --           google_scholar = {
  --             name = "Google Scholar",
  --             get_url = require("cmp_vimtex").url_default_format("https://scholar.google.com/scholar?hl=en&q=%s"),
  --           },
  --         },
  --       },
  --     })
  --   end,
  -- },
}
