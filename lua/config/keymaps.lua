-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--Select all using Ctrl + A
vim.keymap.set("n", "<C-a>", "ggVG", { noremap = true, silent = true, desc = "Select All" })

-- Map Ctrl-h to move the cursor left in Insert mode
vim.api.nvim_set_keymap("i", "<C-h>", "<Left>", { noremap = true, silent = true })

-- Map Ctrl-l to move the cursor right in Insert mode
vim.api.nvim_set_keymap("i", "<C-l>", "<Right>", { noremap = true, silent = true })

-- vim.api.nvim_set_keymap(
--   "v",
--   "gC",
--   ":lua require('mini.comment').toggle_lines( { lines = MiniComment.get_lines({}) })<CR>",
--   { noremap = true, silent = true }
-- )
--[[ vim.api.nvim_set_keymap(
  "v",
  "gC",
  ":lua require('Comment.api').uncomment.linewise(vim.fn.visualmode())<CR>",
  { noremap = true, silent = true }
) ]]
-- Force toggle comment with Command + / (overwrite any existing binding)
-- vim.api.nvim_set_keymap("n", "<D-/>", "gcc", { noremap = false, silent = true })
-- vim.api.nvim_set_keymap("v", "<D-/>", "gc", { noremap = false, silent = true })
-- Toggle comment with Command + /
-- Map Alt-/ to toggle comments

-- local map = vim.keymap.set
-- local comment_api = require("Comment.api") -- Import Comment.nvim's API
--
-- -- Normal mode: Toggle comment on the current line
-- map("n", "<A-/>", function()
--   comment_api.toggle.linewise.current()
-- end, { desc = "Toggle comment line" })
--
-- -- Visual mode: Toggle comment on the selection
-- map("x", "<A-/>", function()
--   -- Use visual mode context to toggle comment
--   comment_api.toggle.linewise(vim.fn.visualmode())
-- end, { desc = "Toggle comment selection" })
