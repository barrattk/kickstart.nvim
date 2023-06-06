



-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
local opts = {noremap = true, silent = true}

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true }) -- leader is the Space



vim.keymap.set('n', '<c-u>', '<c-u>zz') -- Put cursor in middle after movement
vim.keymap.set('n', '<c-d>', '<c-d>zz') -- Put cursor in middle after movement

vim.keymap.set('n', '<c-f>', '<c-f>zz') -- Put cursor in middle after movement
vim.keymap.set('n', '<c-b>', '<c-b>zz') -- Put cursor in middle after movement

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Ranger
vim.keymap.set('n', '<leader>e', function() require('ranger-nvim').open() end, { desc = 'Ranger' })
vim.g.ranger_map_keys=0

-- Better window navigation
vim.keymap.set('n', "<C-h>", "<C-w>h", {desc = "Window Navigation"})
vim.keymap.set('n', "<C-j>", "<C-w>j", {desc = "Window Navigation"})
vim.keymap.set('n', "<C-k>", "<C-w>k", {desc = "Window Navigation"})
vim.keymap.set('n', "<C-l>", "<C-w>l", {desc = "Window Navigation"})

-- Cycle splits
-- vim.keymap.set('n', "<TAB>", "<C-W>w", {desc = "Cycle Splits"})
-- vim.keymap.set('n', "<S-TAB>", "<C-W>W", {desc = "Cycle Splits"})

-- Resize with arrows
vim.keymap.set('n', "<C-Up>", "<cmd>resize -2<CR>", {desc = 'Resize'})
vim.keymap.set('n', "<C-Down>", "<cmd>resize +2<CR>", {desc = 'Resize'})
vim.keymap.set('n', "<C-Left>", "<cmd>vertical resize -2<CR>",{desc = 'Resize'})
vim.keymap.set('n', "<C-Right>", "<cmd>vertical resize +2<CR>",{desc ='Resize'})

-- Navigate buffers
vim.keymap.set('n', "<S-l>", ":bnext<CR>", {desc = 'Buffer (Next)'})
vim.keymap.set('n', "<S-h>", ":bprevious<CR>", {desc = 'Buffer (Prev)'})
vim.keymap.set('n', "<TAB>", ":bn<CR>", {desc = "Cycle buffers"})
vim.keymap.set('n', "<S-TAB>", ":bp<CR>", {desc = "Cycle buffers"})

vim.keymap.set('n', "<leader>x", ":BufDel<CR>", {desc = 'Buffer delete'}) -- requires ojroques/nvim-bufdel

-- Stay in visual_mode after shift operation
vim.keymap.set('v', ">", ">gv", opts)
vim.keymap.set('v', "<", "<gv", opts)

-- Press these to fast to exit insert mode
vim.keymap.set('i', "jj", "<ESC>", opts)
vim.keymap.set('i', "kj", "<ESC>", opts)
vim.keymap.set('i', "jk", "<ESC>", opts)

-- Move text up and down
vim.keymap.set('n', "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
vim.keymap.set('n', "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Move text up and down
vim.keymap.set("v", "<A-j>", ":m .+1<CR>==", opts)
vim.keymap.set("v", "<A-k>", ":m .-2<CR>==", opts)

-- Paste in visual mode
vim.keymap.set("v", "p", '"_dP', opts)
vim.keymap.set("v", "y", 'ygv<esc>', opts)


vim.keymap.set("n", "U", '<C-r>', opts) -- redo with the same key as undo

-- Select Mode is a bit weird and I don't plan on using it
-- See https://vi.stackexchange.com/questions/4891/what-is-the-select-mode-and-when-is-it-relevant-to-use-it
-- Move text up and down
-- vim.keymap.set("x", "J", ":move '>+1<CR>gv-gv", opts)
-- vim.keymap.set("x", "K", ":move '<-2<CR>gv-gv", opts)
-- vim.keymap.set("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
-- vim.keymap.set("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)


-- Use escape to leave insert mode in terminal
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', opts)

vim.keymap.set('n', "<leader>h", ":ClangdSwitchSourceHeader<CR>", {desc = 'ClangdSwitchSourceHeader'})


vim.keymap.set('n', "<leader>sl", "<cmd>lua require('telescope.builtin').resume(require('telescope.themes').get_ivy({}))<CR>", {desc = '[S]each [l]ast Grep'})

vim.keymap.set('n', '<F2>', ':mksession! ~/.local/state/nvim/.vim_session<CR>', {desc = "Session Write"})
vim.keymap.set('n', '<F3>', ':source ~/.local/state/nvim/.vim_session<CR>', {desc = "Session Load"})

-- prompt for a refactor to apply when the remap is triggered
-- vim.api.nvim_set_keymap(
    -- "v",
    -- "<leader>rr",
    -- ":lua require('refactoring').select_refactor()<CR>",
    -- { noremap = true, silent = true, expr = false }
-- )


-- load refactoring Telescope extension
require("telescope").load_extension("refactoring")

-- remap to open the Telescope refactoring menu in visual mode
vim.api.nvim_set_keymap(
	"v",
	"<leader>rr",
	"<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
	{ noremap = true }
)


-- local M = {}

--
-- M.disabled = {
--   n = {
--     ["<C-n>"] = "", -- Cancel this Neo-tree mapping for yanky mapping below
--     ["<leader>e"] = "",
--     ["<leader>x"] = "", -- Cancel this close buffer mapping
--     ["<leader>b"] = "", -- Cancel this new buffer mapping
--   }
-- }
--
-- -- M.tabufline.disabled = {
-- -- n={
-- --     ["<leader>x"] = "", -- Cancel this close buffer mapping
-- --   },
-- -- }
--
-- M.general = {
--   -- Modes
--   --   normal_mode = "n",
--   --   insert_mode = "i",
--   --   visual_mode = "v",
--   --   visual_block_mode = "x",
--   --   term_mode = "t",
--   --   command_mode = "c",
--   n = {
--     [";"] = { ":", "enter command mode", opts = { nowait = true } },
--
--
--     ["<leader>bc"] = {
--       function()
--         require("nvchad_ui.tabufline").close_buffer()
--       end,
--       "close buffer",
--     },
--     ["<leader>bn"] = { "<cmd> enew <CR>", "new buffer" },
--     -- Normal --
--     -- Better window navigation - this built-in to nvchad
--     -- ["C-h"] = {"<C-w>h", "Window Navigation"},
--     -- ["<C-j>"] = {"<C-w>j", "Window Navigation"},
--     -- ["<C-k>"] = {"<C-w>k", "Window Navigation"},
--     -- ["<C-l>"] = {"<C-w>l", "Window Navigation"},
--     --
--     -- -- Resize with arrows
--     ["<C-Up>"] = { "<cmd>resize -2<CR>"},
--     ["<C-Down>"] = {"<cmd>resize +2<CR>"},
--     ["<C-Left>"] = {"<cmd>vertical resize -2<CR>"},
--     ["<C-Right>"] = {"<cmd>vertical resize +2<CR>"},
--     --
--     -- -- Navigate buffers
--     ["<S-l>"] = {":bnext<CR>"},
--     ["<S-h>"] = {":bprevious<CR>"},
--
--     -- Yanky
--     ["p"] = { "<Plug>(YankyPutAfter)", desc = "Yanky Put" },
--     ["P"] = { "<Plug>(YankyPutBefore)", desc = "Yanky Put Before" },
--     ["gp"] = { "<Plug>(YankyPutAfter)", desc = "Yanky Put" },
--     ["gP"] = { "<Plug>(YankyPutBefore)", desc = "Yanky Put Before" },
--
--
--     ["<C-n>"] = { "<Plug>(YankyCycleForward)", desc = "YankyCycleForward" },
--     ["<C-p>"] = { "<Plug>(YankyCycleBackward)", desc = "YankyCycleBackward" },
--     ["<leader>e"] = {
--         function()
--             require("ranger-nvim").open()
--         end,
--         "Ranger",
--     },
--   },
--   t = {
--   },
--   x = {
--     ["p"] = { "<Plug>(YankyPutAfter)", desc = "Yanky Put" },
--     ["P"] = { "<Plug>(YankyPutBefore)", desc = "Yanky Put Before" },
--     ["gp"] = { "<Plug>(YankyPutAfter)", desc = "Yanky Put" },
--     ["gP"] = { "<Plug>(YankyPutBefore)", desc = "Yanky Put Before" },
--   },
--   v= {
--     -- Stay in visual_mode after shift operation
--     [">"] = {">gv", opts = {silent=true}},
--     ["<"] = {"<gv", opts = {silent=true}},
--   },
--
-- }
-- -- ERROR if this is included
-- -- M.tabufline = {
-- --     -- close buffer + hide terminal buffer
-- --     ["<leader>bd"] = {
-- --       function()
-- --         require("nvchad_ui.tabufline").close_buffer()
-- --       end,
-- --       "close buffer",
-- --     },
-- --     ["<leader>bn"] = {
-- --       function()
-- --         require("nvchad_ui.tabufline").new_buffer()
-- --       end,
-- --       "close buffer",
-- --     },
-- -- }
-- --
--
-- -- more keybinds!
-- -- M.nvimtree = {
-- --   n = {
-- --     -- toggle
-- -- --    ["<C-n>"] = { "<cmd> NvimTreeToggle <CR>", "toggle nvimtree" },
-- --
-- --     -- focus
-- --     -- ["<leader>e"] = { "<cmd> NvimTreeFocus <CR>", "focus nvimtree" },
-- --     ["<leader>e"] = { "<cmd> NvimTreeToggle<CR>", "Toggle nvimtree" },
-- --   },
-- -- }
--
-- M.nvterm = {
--   plugin = true,
--
--   t = {
--     -- toggle in terminal mode
--     ["<M-1>"] = {
--       function()
--         require("nvterm.terminal").toggle "horizontal"
--       end,
--       "toggle horizontal term",
--     },
--
--     ["<M-2>"] = {
--       function()
--         require("nvterm.terminal").toggle "vertical"
--       end,
--       "toggle vertical term",
--     },
--
--     ["<M-3>"] = {
--       function()
--         require("nvterm.terminal").toggle "float"
--       end,
--       "toggle floating term",
--     },
--   },
--
--   n = {
--     -- toggle in normal mode
--     ["<M-1>"] = {
--       function()
--         require("nvterm.terminal").toggle "horizontal"
--       end,
--       "toggle horizontal term",
--     },
--
--     ["<M-2>"] = {
--       function()
--         require("nvterm.terminal").toggle "vertical"
--       end,
--       "toggle vertical term",
--     },
--
--     ["<M-3>"] = {
--       function()
--         require("nvterm.terminal").toggle "float"
--       end,
--       "toggle floating term",
--     },
--
--     -- new
--     ["<leader>h"] = {
--       function()
--         require("nvterm.terminal").new "horizontal"
--       end,
--       "new horizontal term",
--     },
--
--     ["<leader>v"] = {
--       function()
--         require("nvterm.terminal").new "vertical"
--       end,
--       "new vertical term",
--     },
--   },
-- }
-- return M
--
