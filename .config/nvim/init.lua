-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
-- Disable Ctrl+Z suspension in Neovim
vim.keymap.set('n', '<C-z>', '<Nop>', { noremap = true, silent = true })
vim.keymap.set('v', '<C-z>', '<Nop>', { noremap = true, silent = true })
vim.keymap.set('i', '<C-z>', '<Nop>', { noremap = true, silent = true })