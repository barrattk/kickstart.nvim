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
    -- 'leoluz/nvim-dap-go',
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
         -- 'delve',  --  Go
        'codelldb', -- C/Cpp
        'debugpy',  -- Python
      },
    }

    -- Don't use F10 or F11 as the OS grabs those

    vim.keymap.set('n', '<F8>', dap.continue, {desc = 'Run'})  -- Use this to start a Session!
    vim.keymap.set('n', '<F5>', dap.step_into, {desc = 'Step Into'})
    vim.keymap.set('n', '<F6>', dap.step_over, {desc = 'Step Over'})
    vim.keymap.set('n', '<F7>', dap.step_out, {desc = 'Step Out'})
    vim.keymap.set('n', '<F3>', dap.restart, {desc = 'Restart'})
    vim.keymap.set('n', '<leader>bb', dap.toggle_breakpoint, {desc = 'Breakpoint (Toggle)'})
    vim.keymap.set('n', '<leader>bc', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, {desc = 'Breakpoint Condition'})

    -- toggle to see last session result. Without this ,you can't see session output in case of unhandled exception.
    vim.keymap.set("n", "<F12>", dapui.toggle, {desc = 'DAP Last Session (Toggle)'})

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- expand_lines = true,
      icons = { expanded = "", collapsed = "", circular = "", current_frame = '*'},
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
      mappings = {
        -- Use a table to apply multiple mappings
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
      },
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.33 },
            { id = "breakpoints", size = 0.17 },
            { id = "stacks", size = 0.25 },
            { id = "watches", size = 0.25 },
          },
          size = 0.33,
          position = "right",
        },
        {
          elements = {
            { id = "repl", size = 0.45 },
            { id = "console", size = 0.55 },
          },
          size = 0.27,
          position = "bottom",
        },
      },
      floating = {
        max_height = 0.9,
        max_width = 0.5, -- Floats will be treated as percentage of your screen.
        border = vim.g.border_chars, -- Border style. Can be 'single', 'double' or 'rounded'
        mappings = {
          close = { "q", "<Esc>" },
        },
      },
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      -- icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      -- controls = {
      --   icons = {
      --     pause = '⏸',
      --     play = '▶',
      --     step_into = '⏎',
      --     step_over = '⏭',
      --     step_out = '⏮',
      --     step_back = 'b',
      --     run_last = '▶▶',
      --     terminate = '⏹',
      --     disconnect = "⏏",
      --   },
      -- },
    }

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    -- require('dap-go').setup()  -- Commented as we don't need Go
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
    --
    -- not setting a python configurations seems to work just fine
    --
    -- The following gives errors!
    -- dap.configurations.python = {
    --   {
    --     name = "My custom Launch file (python)",
    --     type = 'python',
    --     request = 'launch',
    --     program = '$(file)',
    --     -- args ={'-f', "./log_files/test_1.txt", "-k", "72308628870207035"},
    --   }
    -- }
  end
}
