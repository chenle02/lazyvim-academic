-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
-- Neovim options configuration for LazyVim setup
local opt = vim.opt

-- Cursor settings
opt.guicursor = "" -- Disable GUI cursor styling

-- Folding settings
opt.foldmethod = "marker" -- Use markers for folding

-- Wrapping settings
opt.wrap = false -- Disable line wrapping

-- Spell checking
opt.spell = true -- Enable spell checking
opt.spelllang = "en" -- Set spell check language to English
opt.spellfile = vim.fn.expand("$HOME/Dropbox/mydotfiles/my_vim/spell/en.utf-8.add") -- Path to custom spell file

-- Status line
opt.laststatus = 2 -- Always show the status line

-- Cursor highlighting
opt.cursorline = true -- Highlight the current line
opt.cursorcolumn = true -- Highlight the current column

-- Color column
opt.colorcolumn = "+2" -- Highlight the column 2 spaces to the right of the cursor

-- Indentation settings
opt.shiftwidth = 2 -- Number of spaces for each indentation step

-- Splitting windows
opt.splitbelow = true -- Split new windows below the current one
opt.splitright = true -- Split new windows to the right of the current one

-- Auto directory change
opt.autochdir = true -- Automatically change working directory

-- Timeout settings
opt.timeoutlen = 800 -- Timeout length for key mappings in milliseconds

-- Backspace behavior
opt.backspace = { "indent", "eol", "start" } -- Allow backspace over indentation, end-of-line, and start of insert

-- Tab-related settings
opt.tabstop = 2 -- Number of spaces a tab counts for
opt.expandtab = true -- Use spaces instead of tabs

-- Backup and swap files
opt.backup = false -- Disable backup files
opt.writebackup = false -- Disable write backups
opt.swapfile = false -- Disable swap files

-- Grep program
opt.grepprg = "rg --vimgrep" -- Use ripgrep for the :grep command

-- Clipboard settings
opt.clipboard = "unnamedplus" -- Use the system clipboard

-- Conceal level for TeX (commented out, adjust as needed)
-- opt.conceallevel = 2  -- Uncomment to enable conceal level 2 for TeX files

-- Line number settings
opt.relativenumber = true -- Show relative line numbers
opt.number = true -- Show absolute line numbers

-- Textwidth and colors
opt.textwidth = 80 -- Set preferred text width to 80 characters
opt.termguicolors = true -- Enable 256 colors
opt.background = "dark" -- Use a dark background theme

-- Status line and general behavior
opt.laststatus = 2 -- Always show the status line
opt.compatible = false -- Use improved Neovim features (disable compatibility mode)
opt.filetype = "on" -- Enable filetype detection
opt.syntax = "on" -- Enable syntax highlighting

-- Auto read files modified outside of Neovim
opt.autoread = true -- Automatically reload files changed externally
