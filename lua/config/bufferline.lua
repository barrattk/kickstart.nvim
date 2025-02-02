
-- local map = vim.api.nvim_set_keymap
local map = vim.keymap.set
local opts = { noremap = true, silent = true }


local M = {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  -- keys = {keymap},
}


M.config = function ()

    local bufferline = require('bufferline')
    bufferline.setup{
        options = {
            style_preset = bufferline.style_preset.no_italic,
            numbers = "ordinal",
            -- or you can combine these e.g.
            -- style_preset = {
            --     bufferline.style_preset.no_italic,
            --     bufferline.style_preset.no_bold
            -- },
            indicator = {
                icon = '▎', -- this should be omitted if indicator style is not 'icon'
                style = 'underline',  -- 'icon' | 'none',
            },
        }
    }

    map('n', '<A-1>', '<CMD>BufferLineGoToBuffer 1<CR>', opts)
    map('n', '<A-2>', '<CMD>BufferLineGoToBuffer 2<CR>', opts)
    map('n', '<A-3>', '<CMD>BufferLineGoToBuffer 3<CR>', opts)
    map('n', '<A-4>', '<CMD>BufferLineGoToBuffer 4<CR>', opts)
    map('n', '<A-5>', '<CMD>BufferLineGoToBuffer 5<CR>', opts)
    map('n', '<A-6>', '<CMD>BufferLineGoToBuffer 6<CR>', opts)
    map('n', '<A-7>', '<CMD>BufferLineGoToBuffer 7<CR>', opts)
    map('n', '<A-8>', '<CMD>BufferLineGoToBuffer 8<CR>', opts)
    map('n', '<A-9>', '<CMD>BufferLineGoToBuffer 9<CR>', opts)
    -- Last visable buffer
    map('n', '<A-0>', '<Cmd>BufferLineGoToBuffer -1<CR>', opts)

    map('n', '<C-p>', '<CMD>BufferLinePick<CR>', opts)
end


return M

