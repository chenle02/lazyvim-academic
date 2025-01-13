return {
  "nvim-telescope/telescope.nvim",
  lazy = false,
  dependencies = {
    { "nvim-lua/plenary.nvim" }, -- Required for Telescope
    { "nvim-telescope/telescope-fzy-native.nvim" }, -- Fuzzy finder
    { "nvim-telescope/telescope-file-browser.nvim" }, -- File browser extension
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, -- FZF native extension
    { "nvim-telescope/telescope-frecency.nvim", dependencies = { "tami5/sqlite.lua" } }, -- Frecency support
    { "mfussenegger/nvim-dap" }, -- Required for Telescope DAP
    { "nvim-telescope/telescope-dap.nvim" }, -- Telescope DAP extension
    { "nvim-telescope/telescope-github.nvim" }, -- GitHub extension
    { "nvim-telescope/telescope-media-files.nvim" }, -- Preview media files
    { "dhruvmanila/telescope-bookmarks.nvim" }, -- Bookmark support
    { "jvgrootveld/telescope-zoxide" }, -- Zoxide integration
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")
    local utils = require("telescope.utils")

    -- Custom actions
    local custom_actions = {}

    function custom_actions._multiopen(prompt_bufnr, open_cmd)
      local picker = action_state.get_current_picker(prompt_bufnr)
      local num_selections = #picker:get_multi_selection()
      if num_selections > 1 then
        local cwd = picker.cwd or ""
        vim.cmd("bw!")
        for _, entry in ipairs(picker:get_multi_selection()) do
          vim.cmd(string.format("%s %s%s", open_cmd, cwd, entry.value))
        end
        vim.cmd("stopinsert")
      else
        if open_cmd == "vsplit" then
          actions.file_vsplit(prompt_bufnr)
        elseif open_cmd == "split" then
          actions.file_split(prompt_bufnr)
        elseif open_cmd == "tabe" then
          actions.file_tab(prompt_bufnr)
        else
          actions.select_default(prompt_bufnr)
        end
      end
    end

    -- Telescope setup
    telescope.setup({
      defaults = {
        mappings = {
          i = { ["<C-h>"] = "which_key" },
        },
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--trim",
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
        file_browser = {
          theme = "ivy",
        },
        frecency = {
          db_root = "$HOME/.local/share/nvim/",
          show_scores = false,
          show_unindexed = true,
          ignore_patterns = { "*.git/*", "*/tmp/*" },
          disable_devicons = false,
          workspaces = {
            ["conf"] = "$HOME/.config",
            ["data"] = "$HOME/.local/share",
            ["project"] = "$HOME/Dropbox/workspace/svn/",
            ["wiki"] = "$HOME/Dropbox/vimwiki",
          },
        },
        bibtex = {
          -- Depth for the *.bib file
          depth = 1,
          -- Custom format for citation label
          custom_formats = {},
          -- Format to use for citation label.
          -- Try to match the filetype by default, or use 'plain'
          format = "",
          -- Path to global bibliographies (placed outside of the project)
          global_files = {},
          -- Define the search keys to use in the picker
          search_keys = { "author", "year", "title" },
          -- Template for the formatted citation
          citation_format = "{{author}} ({{year}}), {{title}}.",
          -- Only use initials for the authors first name
          citation_trim_firstname = true,
          -- Max number of authors to write in the formatted citation
          -- following authors will be replaced by "et al."
          citation_max_auth = 2,
          -- Context awareness disabled by default
          context = false,
          -- Fallback to global/directory .bib files if context not found
          -- This setting has no effect if context = false
          context_fallback = true,
          -- Wrapping in the preview window is disabled by default
          wrap = false,
        },
      },
    })

    -- Load extensions
    telescope.load_extension("fzf")
    telescope.load_extension("file_browser")
    telescope.load_extension("frecency")
    telescope.load_extension("dap")
    telescope.load_extension("gh")
    telescope.load_extension("media_files")
    telescope.load_extension("zoxide")
    telescope.load_extension("bookmarks")

    -- Keymaps for Telescope
    local keymap = vim.api.nvim_set_keymap
    local opts = { noremap = true, silent = true }

    -- keymap("n", ";f", "<cmd>Telescope find_files<CR>", opts)
    -- keymap("n", ";r", "<cmd>Telescope live_grep<CR>", opts)
    -- keymap("n", ";b", "<cmd>Telescope buffers<CR>", opts)
    -- keymap("n", ";h", "<cmd>Telescope help_tags<CR>", opts)
    -- keymap("n", ";d", "<cmd>Telescope diagnostics<CR>", opts)
    -- keymap("n", ";g", "<cmd>Telescope git_files<CR>", opts)
    --
    -- -- Additional keymaps for help tags
    -- keymap("n", ";;", [[<Cmd>lua require'telescope.builtin'.help_tags({results_title='Help Results'})<CR>]], opts)
    --
    -- -- Additional keymaps for file browser
    -- keymap("n", ";p", [[<cmd>lua require'telescope'.extensions.file_browser.file_browser()<CR>]], opts)

    -- Additional keymap for frecency
    keymap(
      "n",
      "``",
      "<Cmd>lua require('telescope').extensions.frecency.frecency()<CR>",
      { noremap = true, silent = true }
    )
  end,
}
