-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({timeout=200})
  end,
  group = highlight_group,
  pattern = '*',
})

-- Save session on when exiting - will get odd if using more than one window!!
-- Maybe not needed?
vim.api.nvim_create_autocmd('QuitPre', {
  pattern = { "*" },
  command = [[:mksession! ~/.local/state/nvim/.vim_session]],
})

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { "*" },
  command = [[%s/\s\+$//e ]],
})

