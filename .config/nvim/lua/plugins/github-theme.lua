return {
  -- 1. Configure the theme plugin itself
  {
    "projekt0n/github-nvim-theme",
    lazy = false, -- Make sure it loads on startup
    priority = 1000, -- Make sure it loads before everything else
    config = function()
      require("github-theme").setup({
        options = {
          transparent = false,
          styles = {
            comments = "italic",
            keywords = "bold",
            functions = "italic,bold",
            variables = "NONE",
          },
          darken = {
            floats = true,
            sidebars = {
              enable = true,
              list = { "qf", "help" },
            },
          },
        },
      })
    end,
  },

  -- 2. Tell LazyVim to activate this theme natively
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "github_dark_high_contrast",
    },
  },
}