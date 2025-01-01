
local M = {
    "christoomey/vim-tmux-navigator",
    lazy=false,
    -- Better window navigation using vim-tmux-navigator
    vim.keymap.set({ 'n', 't' }, "<C-h>", "<cmd> TmuxNavigateLeft<CR>", {desc = "Window Navigation"}),
    vim.keymap.set({ 'n', 't' }, "<C-j>", "<cmd> TmuxNavigateDown<CR>", {desc = "Window Navigation"}),
    vim.keymap.set({ 'n', 't' }, "<C-k>", "<cmd> TmuxNavigateUp<CR>",  {desc = "Window Navigation"}),
    vim.keymap.set({ 'n', 't' }, "<C-l>", "<cmd> TmuxNavigateRight<CR>", {desc = "Window Navigation"}),
}


-- M.config = function()
--   require('vim-tmux-navigator').setup {
--
--
--   }
-- end

return M
