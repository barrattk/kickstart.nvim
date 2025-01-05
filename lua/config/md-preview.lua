local M = {

  "topazape/md-preview.nvim",
  ft = { "md", "markdown", "mkd", "mkdn", "mdwn", "mdown", "mdtxt", "mdtext", "rmd", "wiki" },
}

M.config = function()
      require("md-preview").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the setup section belowlocal mp = require("md-preview")
      viewer = {
        -- mdcat
        exec = "mdcat",
        exec_path = "",
        args = { "--local" },

        -- glow
        -- exec = "glow",
        -- exec_path = "",
        -- args = { "-s", "dark" },

        -- terminal markdown viewer
        -- exec = "mdv",
        -- exec_path = "",
        -- args = { "-c", 80 },
      },
      -- Markdown preview term
      term = {
        -- reload term when rendered markdown file changed
        reload = {
          enable = true,
          events = {"InsertLeave", "TextChanged"},
        },
        direction = "vertical", -- choices: vertical / horizontal
        keys = {
          close = {"q"},
          refresh = "r",
        },
      },
    }
end

return M
