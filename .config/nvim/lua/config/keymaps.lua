-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here



-- Enhanced Terminal Management for LazyVim
local map = vim.keymap.set

-- Terminal mode shortcuts
-- Exit terminal mode easily
-- map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
-- map("t", "jk", "<C-\\><C-n>", { desc = "Exit terminal mode (alternative)" })






-- Horizontal terminal
-- map("n", "<C-\\>", function()
--   vim.cmd("split")
--   vim.cmd("terminal")
--   vim.cmd("resize 15")
--   vim.cmd("startinsert")
-- end, { desc = "Horizontal terminal" })

-- Vertical terminal
-- map("n", "<leader>tv", function()
--   vim.cmd("vsplit")
--   vim.cmd("terminal")
--   vim.cmd("startinsert")
-- end, { desc = "Vertical terminal" })

-- Full terminal tab
-- map("n", "<leader>tt", function()
--   vim.cmd("tabnew")
--   vim.cmd("terminal")
--   vim.cmd("startinsert")
-- end, { desc = "Terminal in new tab" })



