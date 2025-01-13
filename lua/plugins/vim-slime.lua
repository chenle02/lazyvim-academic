return {
  "jpalardy/vim-slime",
  config = function()
    -- Configure vim-slime
    vim.g.slime_target = "tmux"
    vim.g.slime_default_config = {
      socket_name = "default", -- Default tmux socket
      target_pane = "{last}", -- Target the last active pane
    }

    -- Key mappings for vim-slime
    vim.keymap.set(
      "x",
      "<C-c><C-c>",
      "<Plug>SlimeRegionSend",
      { silent = true, desc = "Send selected region to Slime" }
    )
    vim.keymap.set("n", "<C-c><C-c>", "<Plug>SlimeParagraphSend", { silent = true, desc = "Send paragraph to Slime" })

    -- Sync directory and open with vifm
    function _G.SyncDirSlime()
      local cmdstr = "SlimeSend1 vifm " .. vim.fn.expand("%:p:h")
      vim.cmd("echom '" .. cmdstr .. "'")
      vim.cmd(cmdstr)
    end
    vim.keymap.set(
      "n",
      "<C-c>f",
      ":call v:lua.SyncDirSlime()<CR>",
      { silent = true, desc = "Sync directory and open with vifm" }
    )
  end,
}
