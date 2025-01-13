return {
  "tpope/vim-surround",
  keys = {
    -- Surround normal mode mappings
    { "ds", mode = "n", desc = "Delete surrounding" },
    { "cs", mode = "n", desc = "Change surrounding" },
    { "ys", mode = "n", desc = "Add surrounding" },
    { "yS", mode = "n", desc = "Add surrounding (to line)" },
    { "yss", mode = "n", desc = "Add surrounding (entire line)" },

    -- Surround visual mode mappings
    { "S", mode = "x", desc = "Add surrounding (visual mode)" },
  },
}
