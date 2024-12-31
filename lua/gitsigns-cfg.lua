
local M= {
  'lewis6991/gitsigns.nvim',
}

M.config = function ()
  require('gitsigns').setup{


    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map('n', ']c', function()
        if vim.wo.diff then return ']c' end
        vim.schedule(function() gs.next_hunk() end)
        return '<Ignore>'
      end, {expr=true})

      map('n', '[c', function()
        if vim.wo.diff then return '[c' end
        vim.schedule(function() gs.prev_hunk() end)
        return '<Ignore>'
      end, {expr=true})

      -- Actions
      map('n', '<leader>hs', gs.stage_hunk, { desc = 'Stage Hunk'})
      map('n', '<leader>hr', gs.reset_hunk, { desc = 'Reset Hunk'})
      map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = 'Stage Hunk'})
      map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = 'Reset Hunk'})
      map('n', '<leader>hS', gs.stage_buffer, { desc = 'Stage buffer'})
      map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'Undo_stage_hunk'})
      map('n', '<leader>hR', gs.reset_buffer, { desc = 'Reset buffer'})
      map('n', '<leader>hp', gs.preview_hunk, { desc = 'Preview Hunk'})
      map('n', '<leader>hb', function() gs.blame_line{full=true} end, { desc = 'Blame Line'})
      map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'Toggle blame_line'})
      map('n', '<leader>hd', gs.diffthis, { desc = 'Diff this'})
      map('n', '<leader>hD', function() gs.diffthis('~') end, { desc = 'Diff this'})
      map('n', '<leader>td', gs.toggle_deleted, { desc = 'toggle_deleted'})

      -- Text object
      map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end
  }
end

return M

--     require('gitsigns').setup {
--     -- require('gitsigns').setup {
--       signs = {
--         add          = { text = '│' },
--         change       = { text = '│' },
--         delete       = { text = '_' },
--         topdelete    = { text = '‾' },
--         changedelete = { text = '~' },
--         untracked    = { text = '┆' },
--       },
--     --   signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
--     --   numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
--     --   linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
--     --   word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
--     --   watch_gitdir = {
--     --     follow_files = true
--     --   },
--     --   auto_attach = true,
--     --   attach_to_untracked = false,
--     --   current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
--     --   current_line_blame_opts = {
--     --     virt_text = true,
--     --     virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
--     --     delay = 1000,
--     --     ignore_whitespace = false,
--     --     virt_text_priority = 100,
--     --   },
--     --   current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
--     --   sign_priority = 6,
--     --   update_debounce = 100,
--     --   status_formatter = nil, -- Use default
--     --   max_file_length = 40000, -- Disable if file is longer than this (in lines)
--     --   preview_config = {
--     --     -- Options passed to nvim_open_win
--     --     border = 'single',
--     --     style = 'minimal',
--     --     relative = 'cursor',
--     --     row = 0,
--     --     col = 1
--     --   },
--     --   yadm = {
--     --     enable = false
--     -- --   },
--     -- }
--     -- opts  {
--     --     -- See `:help gitsigns.txt`
--     --     signs = {
--     --       add = { text = '+' },
--     --       change = { text = '~' },
--     --       delete = { text = '_' },
--     --       topdelete = { text = '‾' },
--     --       changedelete = { text = '~' },
--     --     },
--     on_attach = function(bufnr)
--       -- vim.keymap.set('n', '[c', require('gitsigns').prev_hunk, { buffer = bufnr, desc = 'Go to Previous Hunk' })
--       -- vim.keymap.set('n', ']c', require('gitsigns').next_hunk, { buffer = bufnr, desc = 'Go to Next Hunk' })
--       vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk, { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
--       vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk, { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
--       vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk, { buffer = bufnr, desc = '[P]review [H]unk' })
--     end,
--      }
--   end,
-- }
