
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


