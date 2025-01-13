-- File: ~/.config/nvim/lua/plugins/fzf.lua
return {
  "junegunn/fzf.vim",
  dependencies = { "junegunn/fzf" },
  config = function()
    -- Enable per-command history and set history directory
    vim.g.fzf_history_dir = vim.fn.expand("~/.local/share/fzf-history")

    -- Set the preview window options
    vim.g.fzf_preview_window = "right:60%"

    -- Jump to existing window if possible for buffers
    vim.g.fzf_buffers_jump = 1

    -- Customize git log options for commits
    vim.g.fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

    -- Command to generate tags file
    vim.g.fzf_tags_command = "ctags -R"

    -- Set expect options for commands
    vim.g.fzf_commands_expect = "alt-enter,ctrl-x"

    -- Set preview command using bat
    vim.g.fzf_preview_command = "bat --color=always --plain {-1}"

    -- Configure layout and default options
    vim.g.fzf_layout = { window = { width = 0.9, height = 0.9 } }
    vim.env.FZF_DEFAULT_OPTS = "--ansi --preview-window 'right:60%' --layout reverse --margin=1,4"
    vim.env.FZF_DEFAULT_COMMAND = "rg --files --ignore-case --hidden -g '!{.git,node_modules,vendor}/*'"

    -- Command to launch file search with preview
    vim.api.nvim_create_user_command("Files", function(opts)
      vim.fn["fzf#vim#files"](opts.args, vim.fn["fzf#vim#with_preview"](), opts.bang == 1 and 1 or 0)
    end, { bang = true, nargs = "?", complete = "dir" })

    -- FZF statusline customization
    vim.api.nvim_exec(
      [[
      function! s:fzf_statusline()
        highlight fzf1 ctermfg=161 ctermbg=251
        highlight fzf2 ctermfg=23 ctermbg=251
        highlight fzf3 ctermfg=237 ctermbg=251
        setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
      endfunction
      autocmd! User FzfStatusLine call <SID>fzf_statusline()
      ]],
      false
    )

    -- Word completion using FZF in insert mode
    vim.api.nvim_set_keymap(
      "i",
      "<F1>",
      [[<C-R>=fzf#vim#complete({'source': map(complete_info().items, "v:val.word")})<CR>]],
      { noremap = true, silent = true, expr = true }
    )
  end,
}
