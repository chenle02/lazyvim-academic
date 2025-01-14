return {
  "github/copilot.vim",
  config = function()
    -- Disable default `<Tab>` mapping
    vim.g.copilot_no_tab_map = true

    -- Remap Copilot's accept function to `<C-l>`
    vim.api.nvim_set_keymap("i", "<c-]>", 'copilot#Accept("<CR>")', { silent = true, expr = true, noremap = true })

    -- Disable Treesitter conflict, if you are using Treesitter
    vim.g.copilot_no_treesitter = true
  end,
}
