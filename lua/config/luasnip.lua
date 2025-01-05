
local M = {
	"L3MON4D3/LuaSnip",
	-- follow latest release.
	version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	-- install jsregexp (optional!).
	build = "make install_jsregexp",

  dependencies = {
     { "rafamadriz/friendly-snippets" },
  }
}


M.config = function()

  require("luasnip.loaders.from_vscode").lazy_load()

-- Key mappings are not required as they appear in with the auto-completion
-- plugin (blink.lua at the time of writing)

-- local ls = require("luasnip")

-- vim.keymap.set({"i"}, "<leader><C-K>", function() ls.expand() end, {silent = true})
-- vim.keymap.set({"i", "s"}, "<leader><C-L>", function() ls.jump( 1) end, {silent = true})
-- vim.keymap.set({"i", "s"}, "<leader><C-J>", function() ls.jump(-1) end, {silent = true})
--
-- vim.keymap.set({"i", "s"}, "<leader><C-E>", function()
-- 	if ls.choice_active() then
-- 		ls.change_choice(1)
-- 	end
-- end, {silent = true})

end

return M

