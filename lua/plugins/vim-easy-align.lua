return {
  {
    "junegunn/vim-easy-align",
    config = function()
      -- Start interactive EasyAlign in visual mode (e.g., vipga)
      vim.api.nvim_set_keymap("x", "ga", "<Plug>(EasyAlign)", { noremap = false, silent = true })
      -- Start interactive EasyAlign for a motion/text object (e.g., gaip)
      vim.api.nvim_set_keymap("n", "ga", "<Plug>(EasyAlign)", { noremap = false, silent = true })

      -- Set up Markdown-specific EasyAlign binding
      vim.cmd([[
        augroup EasyAlignMarkdown
          autocmd!
          autocmd FileType markdown vmap <tab> :EasyAlign*<Bar><Enter>
        augroup END
      ]])
    end,
  },
}
