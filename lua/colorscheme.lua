




-- return {
--     -- Theme inspired by Atom
--     'navarasu/onedark.nvim',
--     priority = 1000,
--     config = function()
--       vim.cmd.colorscheme 'onedark'
--     end,
--   }

return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
  config = function ()
    -- vim.cmd.colorscheme 'tokyonight-storm'
    -- vim.cmd.colorscheme 'tokyonight-night'
    vim.cmd.colorscheme 'tokyonight-moon'
  end
}
