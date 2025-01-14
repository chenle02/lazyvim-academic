return {
  "skywind3000/asyncrun.vim",
  config = function()
    vim.g.asyncrun_open = 6
    vim.g.asyncrun_rootmarks = { ".git", ".svn", ".hg", ".root" }
    vim.g.asyncrun_rootpatterns = { ".git", ".svn", ".hg", ".root" }
  end,
}
