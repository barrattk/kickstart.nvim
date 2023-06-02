-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
    'mfussenegger/nvim-dap-python',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_setup = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'delve',
        'codelldb',
        'debugpy'
      },
    }

    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set('n', '<F5>', dap.continue, {desc = 'Continue'})
    vim.keymap.set('n', '<F1>', dap.step_into, {desc = 'Step Into'})
    vim.keymap.set('n', '<F2>', dap.step_over, {desc = 'Step Over'})
    vim.keymap.set('n', '<F3>', dap.step_out, {desc = 'Step Out'})
    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, {desc = 'Breakpoint (Toggle)'})
    vim.keymap.set('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, {desc = 'Breakpoint Condition'})

vim.keymap.set('n', "<S-l>", ":bnext<CR>", {desc = 'Buffer (Next)'})
    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = "⏏",
        },
      },
    }
    -- toggle to see last session result. Without this ,you can't see session output in case of unhandled exception.
    vim.keymap.set("n", "<F7>", dapui.toggle)

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    -- require('dap-go').setup()
    --
    -- lvim.builtin.dap.on_config_done = function(dap)
    dap.adapters.codelldb = {
      type = "server",
      -- port = "${port}",

      executable = {
        -- provide the absolute path for `codelldb` command if not using the one installed using `mason.nvim`
        command = "codelldb",
        args = { "--port", "${port}" },
        port = function()
          local val = tonumber(vim.fn.input("Port: ", "54321"))
          assert(val, "Please provide a port number")
          return val
        end,

        -- On windows you may have to uncomment this:
        -- detached = false,
      },
    }



    dap.configurations.cpp = {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
          local path
          vim.ui.input({ prompt = "Path to executable: ", default = vim.loop.cwd() .. "/_build/" }, function(input)
            path = input
          end)
          vim.cmd [[redraw]]
          return path
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      },
    }

    dap.configurations.c = dap.configurations.cpp

    dap.configurations.python = {
      {
        name = "My custom Launch file (python)",
        type = 'python',
        request = 'launch',
        program = '$(file)',
        args ={'-f', "./log_files/test_1.txt", "-k", "72308628870207035"},
      }
    }
  end
}
