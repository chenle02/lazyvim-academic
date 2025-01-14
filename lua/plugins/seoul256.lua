return {
  {
    "junegunn/seoul256.vim",
    lazy = false, -- Load the plugin immediately
    priority = 1000, -- Ensure it loads before other plugins
    config = function()
      -- Configure Seoul256 settings
      vim.g.seoul256_background = 233 -- Set the background color variant
      vim.g.seoul256_disable_background = false -- Optional: Transparent background
      vim.g.seoul256_bold = 1 -- Optional: Enable bold text

      -- Apply the color scheme using :Colors
      -- vim.cmd("Colors seoul256")
      pcall(vim.cmd, "colorscheme seoul256")
    end,
  },
}
