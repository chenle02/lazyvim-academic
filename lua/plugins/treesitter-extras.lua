return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- Merge your custom settings with LazyVim's defaults
      opts.ensure_installed = {
        "c",
        "lua",
        "vim",
        "vimdoc",
        "python",
        "help",
        "bash",
        "query",
        "yaml",
        "html",
        "javascript",
      }
      opts.sync_install = true
      opts.auto_install = true
      opts.ignore_install = { "latex" }
      opts.highlight = {
        enable = false, -- Disable highlighting
        additional_vim_regex_highlighting = false,
      }
      opts.incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",
          scope_incremental = "grc",
          node_incremental = "gni",
          node_decremental = "gnd",
        },
      }
      opts.indent = { enable = true }
      opts.fold = { enable = true }
      opts.textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
        swap = {
          enable = true,
          swap_next = { ["<leader>a"] = "@parameter.inner" },
          swap_previous = { ["<leader>A"] = "@parameter.inner" },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = "@class.outer",
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]["] = "@class.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[]"] = "@class.outer",
          },
        },
        lsp_interop = {
          enable = true,
          border = "none",
          peek_definition_code = {
            ["<leader>df"] = "@function.outer",
            ["<leader>dF"] = "@class.outer",
          },
        },
      }
      opts.rainbow = {
        enable = true,
        extended_mode = true, -- Also highlight non-bracket delimiters
        max_file_lines = nil, -- No limit
      }
      opts.playground = {
        enable = true,
        updatetime = 25,
        keybindings = {
          toggle_query_editor = "o",
          toggle_hl_groups = "i",
          toggle_injected_languages = "t",
          toggle_anonymous_nodes = "a",
          toggle_language_display = "I",
          focus_language = "f",
          unfocus_language = "F",
          update = "R",
          goto_node = "<cr>",
          show_help = "?",
        },
      }
    end,
  },
  { "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" },
  { "p00f/nvim-ts-rainbow", after = "nvim-treesitter" },
  { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
}
