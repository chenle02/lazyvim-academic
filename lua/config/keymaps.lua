-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

-- Neovim keybindings configuration
local keymap = vim.keymap

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
