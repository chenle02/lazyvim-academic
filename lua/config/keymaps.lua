-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

-- Neovim keybindings configuration
local keymap = vim.keymap

-- -- Set leader key
-- vim.g.mapleader = "\\" -- Set leader key to backslash

-- Spelling: Choose the first suggestion
keymap.set("n", "]ss", "]sz=1<CR><CR>")
keymap.set("n", "[ss", "[sz=1<CR><CR>")

-- Remove trailing whitespace
-- https://vim.fandom.com/wiki/Remove_unwanted_spaces
keymap.set("n", "ws", function()
  local save_pos = vim.fn.getpos(".") -- Save current cursor position
  vim.cmd("%s/\\s\\+$//e") -- Remove trailing whitespace
  vim.fn.setpos(".", save_pos) -- Restore cursor position
  vim.cmd("write!")
  vim.cmd("redraw")
end)

-- Insert blank line above or below in normal mode
-- https://vi.stackexchange.com/questions/3875/how-to-insert-a-newline-without-leaving-normal-mode
keymap.set("n", "oo", ":<C-u>call append(line('.'), repeat([''], v:count1))<CR>", { silent = true })
keymap.set("n", "OO", ":<C-u>call append(line('.')-1, repeat([''], v:count1))<CR>", { silent = true })

-- Quit Neovim
keymap.set("n", "qq", ":q<CR>", { silent = true })
keymap.set("n", "qw", ":wq!<CR>", { noremap = true, silent = true })

-- Move selected lines upwards or downwards in visual mode
keymap.set("x", "K", ":move '<-2<CR>gv=gv")
keymap.set("x", "J", ":move '>+1<CR>gv=gv")

-- Delete without yanking
keymap.set("n", "<leader>d", '"_d')
keymap.set("x", "<leader>d", '"_d')

-- Paste without overwriting register
keymap.set("v", "\\p", '"_dP')

-- Close all other windows
keymap.set("n", "\\o", ":only<CR>", { silent = true })

-- Close all buffers except the current one
-- https://stackoverflow.com/questions/4545275/vim-close-all-buffers-but-this-one
keymap.set("n", "<leader>bd", ":%bd|e#|bd#<CR>", { silent = true })

-- Move around in insert mode
keymap.set("i", "<C-h>", "<Left>")
keymap.set("i", "<C-l>", "<Right>")
-- keymap.set("i", "<C-j>", "<C-o>gj")
-- keymap.set("i", "<C-k>", "<C-o>gk")
keymap.set("i", "<C-d>", "<End>")

-- Yank file's directory path to clipboard
keymap.set("n", "yf", ":let @+=expand('%:p:h')<CR>")

-- Visual replace/substitute the selected part
-- register h will be used for this purpose
keymap.set("v", "<C-r>", '"hy:bufdo %s/<C-r>h//gc<left><left><left>')
keymap.set("v", "<C-r><C-r>", '"hy:%s/<C-r>h//gc<left><left><left>')

-- Quickfix navigation using space j and space k
keymap.set("n", "<space>j", ":cnext<CR>zz", { silent = true })
keymap.set("n", "<space>k", ":cprevious<CR>zz", { silent = true })

-- FzfLua
keymap.set("n", "//", ":FzfLua lines<cr>", { silent = true })
keymap.set("n", "\\[", ":FzfLua files<cr>", { silent = true })

-- Buffer nevigations
-- Navigate to the previous buffer
keymap.set("n", "\\]", ":bp<CR>", { silent = true })

-- toggle conceal level
-- https://github.com/tpope/vim-unimpaired/issues/105
-- Toggle conceallevel between 0 and 2
vim.keymap.set("n", "=oe", function()
  vim.opt_local.conceallevel = vim.opt_local.conceallevel:get() == 0 and 2 or 0
end, { desc = "Toggle conceallevel" })

-- Adjust conceallevel to 0 or 2
vim.keymap.set("n", "coe", function()
  vim.opt_local.conceallevel = vim.opt_local.conceallevel:get() == 0 and 2 or 0
end, { desc = "Adjust conceallevel to 0 or 2" })

-- Decrease conceallevel
vim.keymap.set("n", "[oe", function()
  vim.opt_local.conceallevel = math.max(vim.opt_local.conceallevel:get() - 1, 0)
end, { desc = "Decrease conceallevel" })

-- Increase conceallevel
vim.keymap.set("n", "]oe", function()
  vim.opt_local.conceallevel = math.min(vim.opt_local.conceallevel:get() + 1, 2)
end, { desc = "Increase conceallevel" })
