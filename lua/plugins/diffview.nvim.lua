return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
  config = function()
    require("diffview").setup({
      enhanced_diff_hl = true, -- Highlight word-level differences
      use_icons = true, -- Requires nvim-web-devicons
      view = {
        merge_tool = {
          layout = "diff3_mixed", -- Layout for merge conflicts
        },
      },
      keymaps = {
        view = {
          ["<leader>e"] = "<cmd>DiffviewToggleFiles<CR>",
          ["<leader>q"] = "<cmd>DiffviewClose<CR>",
        },
      },
    })
  end,
}
