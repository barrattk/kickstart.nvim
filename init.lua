--
-- The starting point was https://github.com/nvim-lua/kickstart.nvim
--
-- See `:help mapleader`
-- NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)


require('lazy').setup({

  -- {
  --   -- 'Exafunction/codeium.vim',
  --   event = 'BufEnter'
  -- },

  -- For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  -- import everything in the lua/config folder
  { import = 'config' },

}, {})

-----------------------------------------------------------------------------------
-- End lazy setup
-----------------------------------------------------------------------------------

require "vim-options"
require 'keymappings'
require 'commands'
require 'auto-commands'

-- vim.keymap.set('n', '<Leader>df', function()
--   local widgets = require('dap.ui.widgets')
--   widgets.centered_float(widgets.frames)
-- end)
-- vim.keymap.set('n', '<leader>ds', require('nvim-dap-ui').eval, { desc = '[d]ebug [s]start' })
