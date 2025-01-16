vim.api.nvim_command("set completeopt=menu,menuone,noselect")

return {
  {
    "hrsh7th/nvim-cmp",

    event = "InsertEnter", -- Load when entering insert mode
    enabled = true,

    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-omni",
      -- "hrsh7th/cmp-spell",
      "github/copilot.vim",
      -- for vimtex
      "micangl/cmp-vimtex",
      -- For vsnip users.
      "aspeddro/cmp-pandoc.nvim",
      "quangnguyen30192/cmp-nvim-ultisnips", -- UltiSnips integration
    },

    opts = function(_, opts)
      local cmp = require("cmp")
      local cmp_fix = require("config.cmp_fix")

      -- Define snippet logic safely
      local function snippet_stop()
        if vim.lsp.util.snippet and vim.lsp.util.snippet.stop then
          vim.lsp.util.snippet.stop()
        end
      end

      opts.snippet = {
        expand = function(args)
          vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users
        end,
      }

      opts.mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping(function()
          snippet_stop()
        end, { "i", "s" }), -- Trigger snippet_stop on <C-e>
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      })

      opts.sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "ultisnips", priority = 900 },
        { name = "buffer", option = { keyword_pattern = [[\k\+]] } },
        -- { name = "path" },
        -- { name = "tags", keyword_length = 2 },
        -- { name = "fuzzy_path" },
        { name = "vimtex" },
        -- { name = "cmp_pandoc" },
        -- { name = "copilot", option = { label = "[copilot]" } },
        -- { name = "tmux", option = { all_panes = false, label = "[tmux]" } },
      })

      window = {
        documentation = {
          border = "rounded", -- Style of the border
          winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder", -- Highlighting
          max_width = 40, -- Maximum width of the documentation window
          max_height = 20, -- Maximum height of the documentation window
        },
      }

      -- Set up custom formatting for completion items
      opts.formatting = {
        format = function(entry, vim_item)
          vim_item.menu = ({
            nvim_lsp = "[LSP]",
            buffer = "[Buffer]",
            path = "[Path]",
            vimtex = vim_item.menu,
          })[entry.source.name]
          return vim_item
        end,
      }

      -- Additional configurations for specific filetypes
      cmp.setup.filetype("tex", {
        sources = cmp.config.sources({
          { name = "vimtex" },
          { name = "buffer" },
          { name = "path" },
          { name = "ultisnips" },
        }),
      })

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

      -- Setup enhanced LSP capabilities
      local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
      local lspconfig = require("lspconfig")
      -- Example LSP server configurations
      lspconfig.lua_ls.setup({ capabilities = capabilities })
      lspconfig.pyright.setup({ capabilities = capabilities })
      lspconfig.tsserver.setup({ capabilities = capabilities })
    end,
  },

  {
    "micangl/cmp-vimtex",
    dependencies = { "hrsh7th/nvim-cmp" }, -- Ensure nvim-cmp is loaded first
    ft = { "tex", "latex" }, -- Load only for LaTeX files
    config = function()
      require("cmp_vimtex").setup({
        additional_information = {
          info_in_menu = true,
          info_in_window = true,
          info_max_length = 60,
          match_against_info = true,
          origin_in_menu = true,
          symbols_in_menu = true,
          bib_highlighting = true,
          highlight_colors = {
            colon_group = "Normal",
            default_key_group = "PreProc",
            default_value_group = "String",
            important_key_group = "Normal",
            important_value_group = "Identifier",
          },
          highlight_links = {
            Annote = "Default",
          },
        },

        bibtex_parser = {
          enabled = true,
        },

        search = {
          browser = "xdg-open",
          default = "google_scholar",
          search_engines = {
            google_scholar = {
              name = "Google Scholar",
              get_url = require("cmp_vimtex").url_default_format("https://scholar.google.com/scholar?hl=en&q=%s"),
            },
          },
        },
      })
    end,
  },
}
