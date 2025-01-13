return {

  -- Still not working, I have my own fork of vim-abook. Check it up latter.
  "dcbaker/vim-abook",

  config = function()
    -- Define the AbookQuery command
    vim.api.nvim_create_user_command("AbookQuery", function(opts)
      vim.fn.AbookQuery(opts.args)
    end, { nargs = 1 })

    -- Insert mode mappings for AbookQueryINS and AbookQueryINSshort
    vim.api.nvim_set_keymap("i", "##", "<esc>:call AbookQueryINS()<CR>", { noremap = true, silent = true })

    vim.api.nvim_set_keymap("i", "@@", "<esc>:call AbookQueryINSshort()<CR>", { noremap = true, silent = true })
  end,
}
