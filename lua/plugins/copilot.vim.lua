return {
  "github/copilot.vim",
  config = function()
    -- Disable default `<Tab>` mapping
    vim.g.copilot_no_tab_map = true

    -- Remap Copilot's accept function to `<C-l>`
    vim.api.nvim_set_keymap("i", "<C-l>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

    -- Disable Treesitter conflict
    vim.g.copilot_no_treesitter = true
  end,
}
