return {
  "ellisonleao/glow.nvim",
  cmd = "Glow",
  config = function()
    require("glow").setup({
      glow_path = "", -- Automatically detected from $PATH if available
      install_path = "~/.local/bin", -- Path for installing the Glow binary
      border = "shadow", -- Floating window border configuration
      style = "dark", -- Override based on your editor's background (options: "dark", "light")
      pager = false, -- Disable pager
      width = 80, -- Fixed width for Glow window
      height = 100, -- Fixed height for Glow window
      width_ratio = 0.7, -- Maximum width of the Glow window relative to Neovim window size
      height_ratio = 0.7, -- Maximum height of the Glow window relative to Neovim window size
    })
  end,
}
