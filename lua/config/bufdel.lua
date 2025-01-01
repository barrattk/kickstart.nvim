
-- Buffer delete
-- This plugin works well - I've tried to replace it but other
-- options are worse (so far)
return {

  'ojroques/nvim-bufdel',

  config = function()
    require('bufdel').setup {
      next = 'tabs',
      quit = true,  -- quit Neovim when last buffer is closed
    }

    -- Why is deleting a buffer complicated?
    -- Following requires ojroques/nvim-bufdel
    vim.keymap.set('n', "<leader>x", ":BufDel<CR>", {desc = 'Buffer delete'})
  end
}
