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


-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--  as they will be available in your neovim runtime.
require('lazy').setup({

  -- Mason
  'williamboman/mason.nvim',

  -- 'p00f/clangd_extensions.nvim',

  -- NOTE: This is where your plugins related to LSP can be installed.
  -- The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      -- { 'j-hui/fidget.nvim', branch ='legacy', tag = 'legacy', commit= '0ba1e16', opts = {} },
      { 'j-hui/fidget.nvim', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
      'saghen/blink.cmp'
    },
  },


  -- require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',
  -- NOTE: The import below automatically adds your own plugins, configuration, etc from `lua/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  -- import everything in the lua/config folder
  {import = 'config'},

}, {})

-----------------------------------------------------------------------------------
-- End lazy setup
-----------------------------------------------------------------------------------



require "vim-options"
require 'keymappings'
require 'commands'
require 'auto-commands'


vim.keymap.set('n', '<Leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end)
-- vim.keymap.set('n', '<leader>ds', require('nvim-dap-ui').eval, { desc = '[d]ebug [s]start' })

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    --local bufarg = buffer = ev.buf
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {desc = "goto declaration",  buffer = ev.buf})
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {desc = "goto definition",  buffer = ev.buf})
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, {desc = "Hover",  buffer = ev.buf})
    -- TODO: clash with other keys
    -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, {desc = "Signature Help",  buffer = ev.buf})
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, {desc = "Add Workspace Folder",  buffer = ev.buf})
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, {desc = "Remove Workspace Folder",  buffer = ev.buf})
    vim.keymap.set('n', '<space>wl',  function()
                                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                                      end, {desc = "List Workspace Folders",  buffer = ev.buf})
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, {desc = "Type definition",  buffer = ev.buf})
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, {desc = "Rename",  buffer = ev.buf})
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, {desc = "Code Action",  buffer = ev.buf})
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
                                      vim.lsp.buf.format { async = true }
                                    end, opts)
  end,
})

-- lsp.on_attach(function(client, bufnr)
--   -- see :help lsp-zero-keybindings
--   -- to learn the available actions
--
--   lsp.default_keymaps({buffer = bufnr})
--
--
--   local nmap = function(keys, func, desc)
--     if desc then
--       desc = 'LSP: ' .. desc
--     end
--
--     vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
--   end
--
--   nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
--   nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
--
--   nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
--   nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
--   nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
--   nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
--
--   nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
--
--   nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
--   nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
--
--   -- See `:help K` for why this keymap
--   nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
--   nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
--
--   -- Lesser used LSP functionality
--   nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
--   nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
--   nmap('<leader>wl', function()
--     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--   end, '[W]orkspace [L]ist Folders')
--
--   -- Create a command `:Format` local to the LSP buffer
--   vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
--     vim.lsp.buf.format()
--   end, { desc = 'Format current buffer with LSP' })
--
-- end)

-- (Optional) Configure lua language server for neovim
-- require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
--
-- lsp.setup()


-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
--local on_attach = function(_, bufnr)
  ---- NOTE: Remember that lua is a real programming language, and as such it is possible
  ---- to define small helper and utility functions so you don't have to repeat yourself
  ---- many times.
  ----
  ---- In this case, we create a function that lets us more easily define mappings specific
  ---- for LSP related items. It sets the mode, buffer and description for us each time.
  --local nmap = function(keys, func, desc)
    --if desc then
      --desc = 'LSP: ' .. desc
    --end
--
    --vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  --end
--
  --nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  --nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
--
  --nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  --nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  --nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  --nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
--
  --nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
--
  --nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  --nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
--
  ---- See `:help K` for why this keymap
  --nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  --nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
--
  ---- Lesser used LSP functionality
  --nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  --nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  --nmap('<leader>wl', function()
    --print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  --end, '[W]orkspace [L]ist Folders')
--
  ---- Create a command `:Format` local to the LSP buffer
  --vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    --vim.lsp.buf.format()
  --end, { desc = 'Format current buffer with LSP' })
--end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
-- They will be installed via Mason
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.



-- some settings can only passed as commandline flags, see `clangd --help`
local clangd_flags = {
  "--background-index",
  "--fallback-style=Google",
  "--all-scopes-completion",
  "--clang-tidy",
  "--log=error",
  "--suggest-missing-includes",
  "--cross-file-rename",
  "--completion-style=detailed",
  "--pch-storage=memory", -- could also be disk
  "--folding-ranges",
  "--enable-config", -- clangd 11+ supports reading from .clangd configuration file
  "--offset-encoding=utf-16", --temporary fix for null-ls
  -- "--limit-references=1000",
  -- "--limit-resutls=1000",
  -- "--malloc-trim",
  -- "--clang-tidy-checks=-*,llvm-*,clang-analyzer-*,modernize-*,-modernize-use-trailing-return-type",
  "--header-insertion=never",
  -- "--query-driver=<list-of-white-listed-complers>"
}


-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
--local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
local capabilities = require('blink.cmp').get_lsp_capabilities()

require("mason").setup()
require("mason-lspconfig").setup()

-- After setting up mason-lspconfig you may set up servers via lspconfig
require("lspconfig").lua_ls.setup {capabilities = capabilities}
-- require("lspconfig").rust_analyzer.setup {}
require("lspconfig").pyright.setup {}
require("lspconfig").clangd.setup {cmd = {"clangd", unpack(clangd_flags) },}

