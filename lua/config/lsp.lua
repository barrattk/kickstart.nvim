local M = {
  -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    { 'williamboman/mason.nvim', config = true },
    'williamboman/mason-lspconfig.nvim',

    -- Useful status updates for LSP
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    -- { 'j-hui/fidget.nvim', branch ='legacy', tag = 'legacy', commit= '0ba1e16', opts = {} },
    { 'j-hui/fidget.nvim',       opts = {} },

    -- Additional lua configuration, makes nvim stuff amazing!
    'folke/neodev.nvim',
    'saghen/blink.cmp'
  },
}

M.config = function()
  require('config.lsp')

    -- Use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        --   local nmap = function(keys, func, desc)
        --     if desc then
        --       desc = 'LSP: ' .. desc
        --     end
        --
        --     vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        --   end

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }

        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = "Goto Declaration", buffer = ev.buf })
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Goto definition", buffer = ev.buf })
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = "References", buffer = ev.buf })
        vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, { desc = 'Goto Implementation', buffer = ev.buf })


        -- TODO: clash with other keys
        -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "Hover", buffer = ev.buf })
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = "Signature Help", buffer = ev.buf })


        -- Workspace
        vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder,
          { desc = "Add Workspace Folder", buffer = ev.buf })
        vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder,
          { desc = "Remove Workspace Folder", buffer = ev.buf })
        vim.keymap.set('n', '<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, { desc = "List Workspace Folders", buffer = ev.buf })


        vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, { desc = "Type definition", buffer = ev.buf })
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = "Rename", buffer = ev.buf })
        vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { desc = "Code Action", buffer = ev.buf })
        vim.keymap.set('n', '<leader>f', function()
          vim.lsp.buf.format { async = true }
        end, { desc = "Format file", buffer = ev.buf })
      end,
    })
  -- some settings can only passed as commandline flags, see `clangd --help`
  local clangd_flags = {
    "--background-index",
    "--fallback-style=LLVM",
    "--all-scopes-completion",
    "--clang-tidy",
    "--log=error",
    "--suggest-missing-includes",
    "--cross-file-rename",
    "--completion-style=detailed",
    "--pch-storage=memory",   -- could also be disk
    "--folding-ranges",
    "--enable-config",        -- clangd 11+ supports reading from .clangd configuration file
    "--offset-encoding=utf-16", --temporary fix for null-ls
    -- "--limit-references=1000",
    -- "--limit-resutls=1000",
    -- "--malloc-trim",
    "--clang-tidy-checks=-*,llvm-*,clang-analyzer-*,modernize-*,-modernize-use-trailing-return-type",
    "--header-insertion=never",
    -- "--query-driver=<list-of-white-listed-complers>"
  }


  -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
  --local capabilities = vim.lsp.protocol.make_client_capabilities()
  -- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
  local capabilities = require('blink.cmp').get_lsp_capabilities()

  require("mason").setup()
  require("mason-lspconfig").setup()

  -- After setting up mason-lspconfig you may set up servers via lspconfig
  require("lspconfig").lua_ls.setup { capabilities = capabilities }
  -- require("lspconfig").rust_analyzer.setup {}
  require("lspconfig").pyright.setup {}
  require("lspconfig").clangd.setup { capabilities = capabilities, cmd = { "clangd", unpack(clangd_flags) }, }
  -- I think that clang-format is just part of clangd even though there is a
  -- separate Mason install for it
  -- require("lspconfig").clang_format.setup { capabilities = capabilities, }
end



return M
