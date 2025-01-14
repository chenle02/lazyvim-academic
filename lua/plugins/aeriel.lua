return {
  "stevearc/aerial.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter", -- For Treesitter integration
    "nvim-tree/nvim-web-devicons", -- For file icons
  },
  opts = {
    on_attach = function(bufnr)
      -- Keymaps for navigating symbols
      vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr, desc = "Aerial: Previous symbol" })
      vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr, desc = "Aerial: Next symbol" })
    end,
  },
  config = function(_, opts)
    -- Setup Aerial with user-defined options
    require("aerial").setup(opts)

    -- Keymap to toggle Aerial
    vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>", { desc = "Toggle Aerial" })
  end,
}
