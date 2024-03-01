local M = {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"saadparwaiz1/cmp_luasnip",
		"L3MON4D3/LuaSnip",
	},
}

M.config = function()
	local cmp = require("cmp")
	vim.opt.completeopt = { "menu", "menuone", "noselect" }



	local function doWhenCmpVisible(fn, timeout, poll_interval)
		if cmp.visible() then
			fn()
			return
		end

		if timeout <= 0 then
			return
		end

		vim.defer_fn(function()
			doWhenCmpVisible(fn, timeout - poll_interval, poll_interval)
		end, poll_interval)
	end

	local function completeAndInsertFirstMatch()
		cmp.complete()
		doWhenCmpVisible(function()
			cmp.select_next_item()
		end, 1100, 50)
	end


	cmp.setup({
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
			end,
		},
		window = {
			-- completion = cmp.config.window.bordered(),
			-- documentation = cmp.config.window.bordered(),
		},
		mapping = cmp.mapping.preset.insert({
			["<C-b>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.abort(),
			["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	    ["<Tab>"] = cmp.mapping({
      c = function()
        if cmp.visible() then
          cmp.select_next_item()
        else
          completeAndInsertFirstMatch()
        end
      end,
      i = function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
          -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
          -- they way you will only jump inside the snippet region
          -- elseif require('luasnip').expand_or_jumpable() then
          --   require('luasnip').expand_or_jump()
        -- elseif has_words_before() then
        --   completeAndInsertFirstMatch()
        else
          fallback()
        end
      end,
      s = function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
          -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
          -- they way you will only jump inside the snippet region
        elseif require('luasnip').expand_or_jumpable() then
          require('luasnip').expand_or_jump()
        -- elseif has_words_before() then
        --   completeAndInsertFirstMatch()
        else
          fallback()
        end
      end
    }),
  }),
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "nvim_lua" },
			{ name = "luasnip" }, -- For luasnip users.
			-- { name = "orgmode" },
		}, {
			{ name = "buffer" },
			{ name = "path" },
		}),
	})

	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = "path" },
		}, {
			{ name = "cmdline" },
		}),
	})
end

return M
