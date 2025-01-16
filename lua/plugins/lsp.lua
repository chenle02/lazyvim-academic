
return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      pyright = {}, -- Python LSP
      tsserver = {}, -- TypeScript/JavaScript LSP
    },
    setup = {
      -- Add custom on_attach logic
      ["*"] = function(client, bufnr)
        -- Enable inlay hints
        if client.server_capabilities.inlayHintProvider then
          vim.lsp.inlay_hint(bufnr, true)
        end
      end,
    },
  },
}
