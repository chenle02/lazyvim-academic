return {
  {
    "aspeddro/cmp-pandoc.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "jbyuki/nabla.nvim", optional = true }, -- Optional dependency
    },
    config = function()
      -- Ensure the plugin is loaded before setup
      require("cmp-pandoc").setup({
        filetypes = { "markdown", "pandoc" },
      })
    end,
  },
}
