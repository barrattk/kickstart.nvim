
local M = {
  "neanias/everforest-nvim",
  lazy = false,
  priority = 1000, -- make sure to load this before all the other start plugins
}

function M.config()
  local everforest = require("everforest")
  everforest.setup({
    background = "hard",
    transparent_background_level = 0,
    dim_inactive_windows = false,
    disable_italic_comments = false,
    italics = true,
    enable_italic = true,
    sign_column_background = "none",
    spell_foreground = false,
    ui_contrast = "low",
    show_eob = false,
    diagnostic_line_highlight = false,
    diagnostic_text_highlight = false,
    diagnostic_virtual_text = "coloured",
    on_highlights = function(hl, _)
      hl["@string.special.symbol.ruby"] = { link = "@field" }
    end,

  })
  everforest.load()
end

return M

-- Using lazy.nvim
-- return {
--   'ribru17/bamboo.nvim',
--   lazy = false,
--   priority = 1000,
--   config = function()
--     require('bamboo').setup {
--       -- Main options --
--       -- NOTE: to use the light theme, set `vim.o.background = 'light'`
--       style = 'vulgaris', -- Choose between 'vulgaris' (regular), 'multiplex' (greener), and 'light'
--       --style = 'multiplex', -- Choose between 'vulgaris' (regular), 'multiplex' (greener), and 'light'
--       toggle_style_key = nil, -- Keybind to toggle theme style. Leave it nil to disable it, or set it to a string, e.g. "<leader>ts"
--       toggle_style_list = { 'vulgaris', 'multiplex', 'light' }, -- List of styles to toggle between
--       transparent = false, -- Show/hide background
--       dim_inactive = false, -- Dim inactive windows/buffers
--       term_colors = true, -- Change terminal color as per the selected theme style
--       ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
--       cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu
--
--       -- Change code style ---
--       -- Options are italic, bold, underline, none
--       -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
--       code_style = {
--         comments = 'italic',
--         conditionals = 'italic',
--         keywords = 'none',
--         functions = 'bold', -- was 'none'
--         namespaces = 'italic',
--         parameters = 'italic',
--         strings = 'none',
--         variables = 'none',
--       },
--
--       -- Lualine options --
--       lualine = {
--         transparent = false, -- lualine center bar transparency
--       },
--
--       -- Custom Highlights --
--       colors = {}, -- Override default colors
--       highlights = {
--       }, -- Override highlight groups
--
--       -- Plugins Config --
--       diagnostics = {
--         darker = true, -- darker colors for diagnostic
--         undercurl = true, -- use undercurl instead of underline for diagnostics
--         background = false, -- use background color for virtual text
--       },
--     }
--     require('bamboo').load()
--   end,
-- }


-- return {
--  "rebelot/kanagawa.nvim",
-- -- Default options:
--   lazy = false,
--   priority = 1000,
--   config = function()
--   require('kanagawa').setup{
--     compile = false,             -- enable compiling the colorscheme
--     undercurl = true,            -- enable undercurls
--     commentStyle = { italic = true },
--     functionStyle = {},
--     keywordStyle = { italic = true},
--     statementStyle = { bold = true },
--     typeStyle = {},
--     transparent = false,         -- do not set background color
--     dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
--     terminalColors = true,       -- define vim.g.terminal_color_{0,17}
--     colors = {                   -- add/modify theme and palette colors
--         palette = {},
--         theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
--     },
--     overrides = function(colors) -- add/modify highlights
--         return {}
--     end,
--     theme = "wave",              -- Load "wave" theme when 'background' option is not set
--     background = {               -- map the value of 'background' option to a theme
--         dark = "wave",           -- try "dragon" !
--         light = "lotus"
--     },
--   }
--
--   require('kanagawa').load()
-- -- setup must be called before loading
-- --vim.cmd("colorscheme kanagawa")
--   end,
-- }



-- return {
--     -- Theme inspired by Atom
--     'navarasu/onedark.nvim',
--     priority = 1000,
--     config = function()
--       vim.cmd.colorscheme 'onedark'
--     end,
--   }

-- return {
--   "folke/tokyonight.nvim",
--   lazy = false,
--   priority = 1000,
--   opts = {},
--   config = function ()
--     -- vim.cmd.colorscheme 'tokyonight-storm'
--     -- vim.cmd.colorscheme 'tokyonight-night'
--     vim.cmd.colorscheme 'tokyonight-moon'
--   end
-- }
