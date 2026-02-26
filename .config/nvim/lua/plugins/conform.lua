return {
  "stevearc/conform.nvim",
  opts = {
    formatters = {
      prettier = {
        prepend_args = {
          -- "--single-quote=true",           -- Use single quotes
          -- "--semi=true",                   -- Add semicolons
          -- "--tab-width=2",                 -- 4 spaces indentation
          -- "--print-width=100",             -- Max line length
          -- "--trailing-comma=es5",          -- Trailing commas where valid in ES5
          -- "--arrow-parens=avoid",          -- Avoid parens on single arg arrows
          -- "--bracket-spacing=true",        -- Spaces in object literals { foo: bar }
          -- "--end-of-line=lf",              -- Unix line endings
          -- "--jsx-single-quote=false",      -- Double quotes in JSX
          -- "--prose-wrap=preserve",         -- Don't wrap markdown
          -- "--bracket-same-line=false",     -- Put > on new line in JSX
          -- "--embedded-language-formatting=auto", -- Format code in markdown
        },
      },
    },
   
  },
}