return {
  "junegunn/gv.vim",
  dependencies = { "tpope/vim-fugitive" }, -- Ensure vim-fugitive is installed
  cmd = { "GV" }, -- Use only the base command without special characters
  keys = {
    {
      "<leader>gv",
      "<cmd>GV<cr>",
      desc = "Git commit history",
    },
    {
      "<leader>gh",
      function()
        vim.cmd("GV!")
      end,
      desc = "Git commit history for current file",
    },
  },
}
