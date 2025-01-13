return {
  "yuki-ycino/fzf-preview.vim",
  branch = "release/remote", -- Specify the branch to use
  build = ":UpdateRemotePlugins", -- Run this after the plugin is installed
  dependencies = { "junegunn/fzf", "junegunn/fzf.vim" }, -- Ensure fzf and fzf.vim are also installed
  config = function()
    -- Optional: Additional setup or configuration
    -- Example: Set a keybinding for launching fzf-preview
    vim.api.nvim_set_keymap(
      "n",
      "<leader>fp",
      ":FzfPreviewProjectFiles<CR>",
      { noremap = true, silent = true, desc = "Fzf Preview Project Files" }
    )
  end,
}
