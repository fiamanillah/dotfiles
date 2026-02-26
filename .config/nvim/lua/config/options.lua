-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- Leader key (must be set before lazy)
-- vim.g.mapleader = " "
-- vim.g.maplocalleader = "\\"

-- local opt = vim.opt

-- Line Numbers
-- opt.number = true              -- Show line numbers
-- opt.relativenumber = true      -- Relative line numbers
-- opt.numberwidth = 4            -- Number column width

-- -- Tabs & Indentation
-- opt.tabstop = 4                -- 4 spaces for tabs
-- opt.shiftwidth = 4             -- 4 spaces for indent width
-- opt.expandtab = true           -- Use spaces instead of tabs
-- opt.autoindent = true          -- Copy indent from current line
-- opt.smartindent = true         -- Smart autoindenting

-- -- Line Wrapping
-- opt.wrap = false               -- Disable line wrapping
-- opt.linebreak = true           -- Break lines at word boundaries

-- -- Search Settings
-- opt.ignorecase = true          -- Ignore case when searching
-- opt.smartcase = true           -- Override ignorecase if search has capitals
-- opt.hlsearch = true            -- Highlight search results
-- opt.incsearch = true           -- Incremental search

-- -- Appearance
-- opt.termguicolors = true       -- True color support
-- opt.background = "dark"        -- Dark mode
-- opt.signcolumn = "yes"         -- Always show sign column
-- opt.cursorline = true          -- Highlight current line
-- opt.colorcolumn = "100"        -- Show column at 100 chars

-- -- Behavior
-- opt.mouse = "a"                -- Enable mouse support
-- opt.clipboard = "unnamedplus"  -- Use system clipboard
-- opt.undofile = true            -- Enable persistent undo
-- opt.swapfile = false           -- Disable swap file
-- opt.backup = false             -- Disable backup file
-- opt.writebackup = false        -- Disable backup before overwriting

-- -- Splits
-- opt.splitright = true          -- Vertical split to right
-- opt.splitbelow = true          -- Horizontal split to bottom

-- -- Performance
-- opt.updatetime = 250           -- Faster completion
-- opt.timeoutlen = 300           -- Time to wait for mapped sequence
-- opt.lazyredraw = false         -- Don't redraw during macros

-- -- Scrolling
-- opt.scrolloff = 8              -- Keep 8 lines above/below cursor
-- opt.sidescrolloff = 8          -- Keep 8 columns left/right of cursor

-- -- Completion
-- opt.completeopt = "menu,menuone,noselect"
-- opt.pumheight = 10             -- Max items in popup menu

-- -- Folding
-- opt.foldmethod = "expr"
-- opt.foldexpr = "nvim_treesitter#foldexpr()"
-- opt.foldenable = false         -- Don't fold by default

-- -- Whitespace Characters
-- opt.list = true
-- opt.listchars = {
--   tab = "→ ",
--   trail = "·",
--   nbsp = "␣",
--   extends = "»",
--   precedes = "«",
-- }

-- -- Window Title
-- opt.title = true
-- opt.titlestring = "%<%F%=%l/%L - nvim"

-- -- Spell Check
-- opt.spell = false
-- opt.spelllang = { "en_us" }

-- -- Command Line
-- opt.showcmd = true
-- opt.cmdheight = 1

-- -- Status Line
-- opt.laststatus = 3             -- Global statusline
-- opt.showmode = false           -- Don't show mode (in statusline already)