return {
  "lervag/vimtex",
  lazy = false, -- Ensure VimTeX is loaded immediately
  ft = { "tex", "latex" }, -- Ensure it only loads for LaTeX files
  init = function()
    -- VimTeX configuration
    vim.g.vimtex_view_method = "zathura"
    vim.g.vimtex_view_general_viewer = "zathura"
    vim.g.vimtex_view_general_options = "-reuse-instance -forward-search @tex @line @pdf"
    vim.g.vimtex_quickfix_mode = 0 -- Disable quickfix by default
    vim.g.vimtex_fold_enabled = 1 -- Enable folding
    vim.g.tex_flavor = "latex" -- Set default TeX flavor to LaTeX

    -- Compiler settings
    vim.g.vimtex_compiler_method = "tectonic"
    vim.g.vimtex_compiler_tectonic = {
      build_dir = "",
      options = { "--keep-logs", "--keep-intermediates", "--synctex" },
    }

    -- Grammar settings
    vim.g.vimtex_grammar_vlty = {
      lt_directory = "/home/lechen/.local/share/nvim/lsp_servers/ltex/ltex-ls-15.2.0/lib",
      lt_command = "",
      lt_disable = "WHITESPACE_RULE",
      lt_enable = "",
      lt_disablecategories = "",
      lt_enablecategories = "",
      server = "yes",
      shell_options = "",
      show_suggestions = 1,
      encoding = "auto",
    }

    vim.g.vimtex_grammar_textidote = { jar = "/opt/textidote/textidote.jar" }

    -- Documentation settings
    vim.g.vimtex_doc_handlers = { "vimtex#doc#handlers#texdoc" }

    -- Toggle math environments
    vim.g.vimtex_env_toggle_math_map = {
      ["$"] = "align*",
      ["$$"] = "align*",
      ["\\["] = "align*",
      ["\\("] = "$",
    }

    -- Folding settings
    vim.g.vimtex_fold_types = {}
    vim.g.vimtex_fold_types_defaults = {
      preamble = { enabled = 1 },
      items = { enabled = 1 },
      comments = { enabled = 1 },
      envs = {
        blacklist = {},
        whitelist = {},
      },
      sections = {
        parse_levels = 0,
        sections = {
          "%(add)?part",
          "%(chapter|addchap)",
          "%(section|addsec)",
          "subsection",
          "subsubsection",
        },
        parts = {
          "appendix",
          "frontmatter",
          "mainmatter",
          "backmatter",
        },
      },
    }

    -- Custom input mappings
    -- -- Still not working
    -- vim.g.vimtex_imaps = {
    --   {
    --     lhs = "o",
    --     rhs = "\\omega",
    --     expr = true,
    --     leader = "\\",
    --     wrapper = "omega",
    --   },
    -- vim.cmd([[
    --   call vimtex#imaps#add_map({
    --         \ 'lhs' : 'r',
    --         \ 'rhs' : 'vimtex#imaps#style_math("mathrm")',
    --         \ 'expr' : 1,
    --         \ 'leader' : '#',
    --         \ 'wrapper' : 'vimtex#imaps#wrap_math'
    --           \})
    --   ]]) -- }
    -- vim.cmd([[
    --   call vimtex#imaps#add_map({ 'lhs' : '1', 'rhs' : '\ell',     'wrapper' : 'vimtex#imaps#wrap_trivial'})
    --   call vimtex#imaps#add_map({ 'lhs' : '2', 'rhs' : '\partial', 'wrapper' : 'vimtex#imaps#wrap_trivial'})
    --   call vimtex#imaps#add_map({ 'lhs' : '3', 'rhs' : '\eta',     'wrapper' : 'vimtex#imaps#wrap_trivial'})
    --   call vimtex#imaps#add_map({ 'lhs' : 'o', 'rhs' : '\Omega',   'wrapper' : 'vimtex#imaps#wrap_trivial'})
    -- ]])

    -- Autocommands for key mappings
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "tex",
      callback = function()
        vim.api.nvim_set_keymap("n", ",b", ":VimtexErrors<CR>:normal <C-w>w<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", ",n", ":cnext<CR>:normal zz<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", ",m", ":cprevious<CR>:normal zz<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>tt", ":VimtexTocOpen<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>t", ":VimtexTocToggle<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<localleader>lt", ":call vimtex#fzf#run()<CR>", { noremap = true, silent = true })
      end,
    })

    -- Spell checking
    vim.opt.spelllang = { "en_gb" }

    -- Source your LaTeX-related Vimscript file
    vim.cmd("source ~/.config/nvim/vimscript/latex_setup.vim")
  end,
}
