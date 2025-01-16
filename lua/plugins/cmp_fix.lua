local M = {}

function M.snippet_stop()
  -- Safely handle snippet stopping
  if vim.lsp.util.snippet and vim.lsp.util.snippet.stop then
    vim.lsp.util.snippet.stop()
  end
end

return M
