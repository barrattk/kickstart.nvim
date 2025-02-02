
local opts = {noremap = true, silent = true}

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true }) -- leader is the Space

vim.keymap.set('n', "<leader><leader>r", "<cmd>source %<CR>", {desc = "Source this file"});
-- Lua
vim.keymap.set('n', "<leader>ll", ":.lua<CR>", {desc = "Run lua file"});
vim.keymap.set('v', "<leader>ll", ":lua<CR>", {desc = "Run lua selection"});

vim.keymap.set('n', '<c-u>', '<c-u>zz') -- Put cursor in middle after movement
vim.keymap.set('n', '<c-d>', '<c-d>zz') -- Put cursor in middle after movement

vim.keymap.set('n', '<c-f>', '<c-f>zz') -- Put cursor in middle after movement
vim.keymap.set('n', '<c-b>', '<c-b>zz') -- Put cursor in middle after movement

vim.keymap.set('n', "n", 'nzzzv') -- Put cursor in middle after movement
vim.keymap.set('n', "N", 'Nzzzv') -- Put cursor in middle after movement

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })


-- Better window navigation - without vim-tmux-navigator
-- vim.keymap.set({ 'n', 't' }, "<C-h>", "<C-w>h", {desc = "Window Navigation"})
-- vim.keymap.set({ 'n', 't' }, "<C-j>", "<C-w>j", {desc = "Window Navigation"})
-- vim.keymap.set({ 'n', 't' }, "<C-k>", "<C-w>k", {desc = "Window Navigation"})
-- vim.keymap.set({ 'n', 't' }, "<C-l>", "<C-w>l", {desc = "Window Navigation"})

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



-- Stay in visual_mode after shift operation
vim.keymap.set('v', ">", ">gv", opts)
vim.keymap.set('v', "<", "<gv", opts)

-- Press these to fast to exit insert mode
vim.keymap.set('i', "jj", "<ESC>", opts)
vim.keymap.set('i', "kj", "<ESC>", opts)
vim.keymap.set('i', "jk", "<ESC>", opts)

-- Move text up and down
-- vim.keymap.set('v', "<A-k>", "<Esc>:m '<-2<CR>gv=gv", opts)
-- vim.keymap.set('v', "<A-j>", "<Esc>:m '>+1<CR>gv=gv", opts)

vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Paste in visual mode
vim.keymap.set("v", "<leader>p", '"_dP', opts)
vim.keymap.set("v", "y", 'ygv<esc>', opts)

-- Set 'Q' to no operation so it's not annoying
vim.keymap.set("n", "Q", "<nop>")


-- Select Mode is a bit weird and I don't plan on using it
-- See https://vi.stackexchange.com/questions/4891/what-is-the-select-mode-and-when-is-it-relevant-to-use-it
-- Move text up and down
-- vim.keymap.set("x", "J", ":move '>+1<CR>gv-gv", opts)
-- vim.keymap.set("x", "K", ":move '<-2<CR>gv-gv", opts)
-- vim.keymap.set("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
-- vim.keymap.set("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)


-- Use escape to leave insert mode in terminal
-- Escape terminal mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', opts)

-- Let bufferline use <M-1>, also known as <A-1>
-- vim.keymap.set({'n', 't'}, '<M-1>', "<cmd>terminal<CR>", {desc = "Terminal"})


vim.keymap.set('n', "<leader>hc", ":ClangdSwitchSourceHeader<CR>", {desc = 'ClangdSwitchSourceHeader'})


-- vim_session is a builtin feature (not a project)
vim.keymap.set('n', '<F2>', ':mksession! ~/.local/state/nvim/.vim_session<CR>', {desc = "Session Write"})
vim.keymap.set('n', '<F3>', ':source ~/.local/state/nvim/.vim_session<CR>', {desc = "Session Load"})


-------------------------------------------------------------------------------
-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>dm', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

vim.keymap.set('n', '<leader>de', function() vim.diagnostic.enable(true) end, { desc = 'Ensable Diagnostics' })
vim.keymap.set('n', '<leader>dd', function() vim.diagnostic.enable(false) end, { desc = 'Disable Diagnostics' })

-- vim.api.nvim_buf_set_keymap(0, 'n', '<leader>dt', ':call v:lua.toggle_diagnostics()<CR>', {silent=true, noremap=true, desc="Diagnostics toggle"})
-- vim.keymap.set('n', '<leader>dt', vim.diagnostic.reset, {silent=true, noremap=true, desc="Diagnostics toggle"})
-- vim.keymap.set('n', '<leader>dt', ':call v:lua.toggle_diagnostics()<CR>', {silent=true, noremap=true, desc="Diagnostics toggle"})

-------------------------------------------------------------------------------

