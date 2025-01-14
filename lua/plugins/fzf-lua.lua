return {
  {
    "ibhagwan/fzf-lua",
    -- optional: you can configure it here or in a separate setup file
    config = function()
      -- Customize FzfLua to use <Esc> to escape
      require("fzf-lua").setup({
        keymap = {
          builtin = {
            ["<Esc>"] = "abort", -- Map <Esc> to abort/close FzfLua
          },
          fzf = {
            ["esc"] = "abort", -- Also map esc to abort in fzf window
          },
        },
      })
    end,
    dependencies = { "nvim-lua/plenary.nvim" }, -- required dependency
  },
}
