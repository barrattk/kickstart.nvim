
  return{
    "kelly-lin/ranger.nvim",
    config = function()
      require("ranger-nvim").setup({ replace_netrw = true })
      vim.api.nvim_set_keymap("n", "<leader>e", "", {
      -- vim.api.nvim_set_keymap("n", "<leader>ef", "", {
        noremap = true,
        callback = function()
          require("ranger-nvim").open(true)
        end,
      })
    end,
  }



-- -- a different Ranger plugin
-- return {
--   'kevinhwang91/rnvimr',
--
--
--   vim.keymap.set("n", "<leader>e", "<cmd>RnvimrToggle<CR>", {desc = "Ranger", noremap=true}),
--   -- vim.g.rnvimr_vanilla == 1,
--   -- vim.api.nvim_set_keymap("n", "<leader>e", "<cmd>RnvimrToggle<CR>", { noremap=true})
--   -- config = function()
--   --   require("Rnvimr").setup({ replace_netrw = true })
--   --   vim.api.nvim_set_keymap("n", "<leader>e", "RnvimrToggle<CR>", {
--   --   -- vim.api.nvim_set_keymap("n", "<leader>ef", "", {
--   --     noremap = true,
--   --     -- callback = function()
--   --     --   require("ranger-nvim").open(true)
--   --     -- end,
--   --   })
--   -- end,
--
-- -- tnoremap <silent> <M-i> <C-\><C-n>:RnvimrResize<CR>
-- -- nnoremap <silent> <M-o> :RnvimrToggle<CR>
-- -- tnoremap <silent> <M-o> <C-\><C-n>:RnvimrToggle<CR>
--
-- }
