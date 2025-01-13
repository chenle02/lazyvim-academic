return {
  "tpope/vim-fugitive",
  cmd = {
    "Git",
    "G",
    "Gdiffsplit",
    "Gvdiffsplit",
    "Gread",
    "Gwrite",
    "Ggrep",
    "GMove",
    "GDelete",
  },
  keys = {
    { "<leader>gs", "<cmd>Git<cr>", desc = "Git status" },
    { "<leader>gc", "<cmd>Git commit<cr>", desc = "Git commit" },
    { "<leader>gp", "<cmd>Git push<cr>", desc = "Git push" },
    { "<leader>gl", "<cmd>Git pull<cr>", desc = "Git pull" },
    { "<leader>gd", "<cmd>Gdiffsplit<cr>", desc = "Git diff" },
  },
  config = function()
    -- Use vim.cmd for raw vimscript-style commands
    vim.cmd([[
      augroup GitMappings
        autocmd!
        autocmd FileType gitcommit nnoremap <buffer> <leader><leader> :wq<cr>
        autocmd FileType fugitive  nnoremap <buffer> <leader><leader> :G push<cr>
      augroup END
    ]])
  end,
}
