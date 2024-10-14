
-- See this:
-- https://github.com/nanotee/nvim-lua-guide/blob/a118d6f585683a94364167d46274595b1959f089/README.md#defining-user-commands
--
--
--

local api = vim.api
if not api.nvim_create_user_command then
  return
end

local cmd = api.nvim_create_user_command

-- Get current working directory  TODO: map it to a key?
-- :lua print(vim.fn.getcwd())

cmd('CWD', function() print(vim.fn.getcwd()) end, { nargs = 0 })


cmd('TagClean', function() vim.api.nvim_command("vs|term make MODEL=U4BM-1-3 clean") end, { nargs = 0 })
cmd('TagBuild', function() vim.api.nvim_command("sp|term bear -- make MODEL=U4BM-1-3 build") end, { nargs = 0 })
cmd('TagProgram', function() vim.api.nvim_command("vs|term make MODEL=U4BM-1-3 program") end, { nargs = 0 })

cmd('AnchorClean', function() vim.api.nvim_command("vs|term make MODEL=Z1-U-3-2 clean") end, { nargs = 0 })
cmd('AnchorBuild', function() vim.api.nvim_command("vs|term bear -- make MODEL=Z1-U-3-2 build") end, { nargs = 0 })
cmd('AnchorProgram', function() vim.api.nvim_command("vs|term make MODEL=Z1-U-3-2 program") end, { nargs = 0 })
