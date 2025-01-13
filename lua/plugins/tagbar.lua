return {
  "preservim/tagbar",
  config = function()
    -- Optional: Keymap to toggle Tagbar
    -- Still not working yet
    vim.keymap.set("n", "<leader>tb", ":TagbarToggle<CR>", { silent = true, desc = "Toggle Tagbar" })
    vim.g.tagbar_position = "left"
  end,
}
