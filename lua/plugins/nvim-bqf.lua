return {
  "kevinhwang91/nvim-bqf",
  event = "QuickFixCmdPost",
  config = function()
    require("bqf").setup({
      auto_enable = true, -- Enable nvim-bqf in the quickfix window automatically
      magic_window = true, -- Keep a consistent view when splitting horizontally
      auto_resize_height = false, -- Automatically resize the quickfix window height

      preview = {
        auto_preview = true, -- Enable preview in the quickfix window automatically
        border = "rounded", -- Use a rounded border for the preview window
        show_title = true, -- Display a title in the preview window
        show_scroll_bar = true, -- Show a scrollbar in the preview window
        delay_syntax = 50, -- Delay syntax highlighting by 50ms
        win_height = 15, -- Height of the preview window for horizontal layout
        win_vheight = 15, -- Height of the preview window for vertical layout
        winblend = 12, -- Transparency for the preview window
        wrap = false, -- Disable line wrapping in the preview window
        buf_label = true, -- Add a label for the current item buffer
        should_preview_cb = nil, -- Callback function to determine preview behavior
      },

      func_map = {
        open = "o",
        openc = "O",
        drop = "d",
        tab = "t",
        toggle_mode = "m",
        toggle_auto_preview = "p",
      },

      filter = {
        fzf = {
          action_for = {
            ["ctrl-t"] = "tabedit", -- Open item in a new tab
            ["ctrl-v"] = "vsplit", -- Open item in a vertical split
            ["ctrl-x"] = "split", -- Open item in a horizontal split
            ["ctrl-q"] = "signtoggle", -- Toggle sign for selected items
            ["ctrl-c"] = "closeall", -- Close quickfix and abort fzf
          },
          extra_opts = { "--bind", "ctrl-o:toggle-all" }, -- Additional options for fzf
        },
      },
    })
  end,
}
