return {
  "vimwiki/vimwiki",
  config = function()
    -- Basic setup
    vim.g.vimwiki_list = {
      {
        path = vim.fn.expand("$HOME/Dropbox/vimwiki"),
        template_path = vim.fn.expand("$HOME/Dropbox/vimwiki/templates"),
        template_default = "default",
        template_ext = ".html",
      },
      {
        path = vim.fn.expand("$HOME/Dropbox/Teaching/svn_teaching/2025_Fall_Math7440/vimwiki"),
        template_path = vim.fn.expand("$HOME/Dropbox/Teaching/svn_teaching/2025_Fall_Math7440/vimwiki/templates/"),
        template_default = "Course",
        template_ext = ".html",
      },
      {
        path = vim.fn.expand("$HOME/Dropbox/Teaching/svn_teaching/2022_Spring_Math7210/vimwiki"),
        template_path = vim.fn.expand("$HOME/Dropbox/Teaching/svn_teaching/2022_Spring_Math7210/vimwiki/templates/"),
        template_default = "Course",
        template_ext = ".html",
      },
      {
        path = vim.fn.expand("$HOME/Dropbox/workspace/svn/Job-applications/homepage/Auburn/vimwiki"),
        path_html = vim.fn.expand("$HOME/Dropbox/workspace/svn/Job-applications/homepage/Auburn/"),
        template_path = vim.fn.expand("$HOME/Dropbox/vimwiki/templates/"),
        template_default = "Auburn",
        template_ext = ".html",
      },
      {
        path = vim.fn.expand("$HOME/Dropbox/workspace/svn/Job-applications/chenle02.github.io/vimwiki"),
        path_html = vim.fn.expand("$HOME/Dropbox/workspace/svn/Job-applications/chenle02.github.io/vimwiki_html"),
        template_path = vim.fn.expand("$HOME/Dropbox/workspace/svn/Job-applications/chenle02.github.io/templates"),
        template_default = "Github",
        template_ext = ".html",
      },
    }

    -- Commands and autocmds
    vim.api.nvim_create_autocmd("BufNewFile", {
      pattern = vim.fn.expand("~/Dropbox/vimwiki/diary/*.wiki"),
      command = ":silent 0r !~/bin/generate-vimwiki-diary-template '%:t'",
    })

    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
      pattern = vim.fn.expand("diary.wiki"),
      command = ":VimwikiDiaryGenerateLinks",
    })

    -- keybinding is still not working.
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "vimwiki",
      callback = function()
        vim.keyrap.set("n", "<leader><leader>", ":w<CR>:Vimwiki2HTML<CR>", { silent = true })
        vim.keymap.set("n", "<leader>rr", "GG:r !~/bin/GenReview.lua<CR>", { silent = true })
        -- vim.api.nvim_buf_set_option(0, "foldmethod", "syntax")
        vim.cmd([[let @u='di(F[a[|Pf]xf]a]da(']])
      end,
    })

    -- Optional: Enable markdown support for specific wikis
    local teaching_tools = {
      path = vim.fn.expand("$HOME/Dropbox/Teaching/svn_teaching/Teaching_Tools"),
      template_path = vim.fn.expand("$HOME/Dropbox/vimwiki/templates"),
      template_default = "Research",
      syntax = "markdown",
      ext = ".md",
      path_html = vim.fn.expand("$HOME/Dropbox/Teaching/svn_teaching/Teaching_Tools/site_html/"),
      custom_wiki2html = "vimwiki_markdown",
      auto_toc = 1,
      markdown_toc = 1,
      template_ext = ".tpl",
    }
    table.insert(vim.g.vimwiki_list, teaching_tools)
  end,
}
