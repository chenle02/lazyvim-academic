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
  -- config = function()
  --   -- Define custom autocommands
  --   vim.api.nvim_create_augroup("GitMappings", { clear = true })
  --
  --   -- Gitcommit filetype mappings
  --   vim.api.nvim_create_autocmd("FileType", {
  --     group = "GitMappings",
  --     pattern = "gitcommit",
  --     callback = function()
  --       vim.api.nvim_buf_set_keymap(0, "n", "<leader>gp", ":w<CR>:G push<CR>", { noremap = true, silent = true })
  --       vim.api.nvim_buf_set_keymap(0, "n", "<leader><leader>", ":wq<CR>", { noremap = true, silent = true })
  --     end,
  --   })
  --
  --   -- Fugitive filetype mappings
  --   vim.api.nvim_create_autocmd("FileType", {
  --     group = "GitMappings",
  --     pattern = "fugitive",
  --     callback = function()
  --       vim.api.nvim_buf_set_keymap(0, "n", "<leader><leader>", ":G push<CR>", { noremap = true, silent = true })
  --     end,
  --   })
  -- end,
}
