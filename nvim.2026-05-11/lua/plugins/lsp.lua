-- lua/plugins/lsp.lua
return {
	-- Treesitter (syntax highlighting, auto based on filetype)
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false, -- Load early for reliable highlighting
		build = ":TSUpdate", -- Automatically update parsers
		config = function()
			require("nvim-treesitter").setup({ -- Note: NOT .configs anymore
				ensure_installed = {
					"lua",
					"vim",
					"yaml",
					"nim",
					"json",
					"xml",
					"bash",
					"markdown",
					"markdown_inline",
					"java",
					"query", -- query for treesitter itself
				},
				highlight = { enable = true },
				indent = { enable = true },
				-- auto_install = true,          -- Optional: auto install missing parsers
			})
		end,
	},
	-- Mason + LSP servers
	{
		"mason-org/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"yamlls",
					"bashls",
					"jsonls",
					"lemminx", -- xml
					-- Nim LSP will be installed via nimlang tools below
				},
			})
		end,
	},
	-- Fast completion
	--
	--  {
	--    "hrsh7th/nvim-cmp",
	--  },
	--
	{
		"hrsh7th/cmp-cmdline",
	},
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"saadparwaiz1/cmp_luasnip",
			--      "L3MON4D3/LuaSnip",
		},
		-- INSERT MODE: manual completion only
		config = function()
			local cmp = require("cmp")
			local types = require("cmp.types")
			cmp.setup({
				completion = {
					autocomplete = false, -- no popup while typing normally
				},

				mapping = cmp.mapping.preset.insert({
					["<CR>"] = cmp.mapping.confirm({ select = false }),
					["<Tab>"] = cmp.mapping.select_next_item(),
					["<S-Tab>"] = cmp.mapping.select_prev_item(),

					-- CTRL-SPACE to open completion menu manually
					["<C-Space>"] = cmp.mapping.complete(),
				}),

				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "path" },
					{ name = "buffer" },
					{ name = "obsidian" }, -- if you're using obsidian.nvim
					{ name = "obsidian_new" }, -- optional
				}),
			})

			-- CMDLINE MODE (":") — auto popup
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
					{ name = "cmdline" },
				}),
				completion = {
					autocomplete = { types.cmp.TriggerEvent.TextChanged }, -- auto popup
				},
			})

			-- SEARCH MODE ("/" and "?") — optional
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})
		end,

		-- 2026-04-10
		--		config = function()
		--			local cmp = require("cmp")
		--			local types = require("cmp.types")
		--			cmp.setup({
		--				completion = {
		--					autocomplete = false, -- no popup while typing normally
		--				},
		--				--				completion = {
		--				--					autocomplete = { require("cmp.types").cmp.TriggerEvent.TextChanged },
		--				--				},
		--				snippet = {
		--					expand = function(args)
		--						require("luasnip").lsp_expand(args.body)
		--					end,
		--				},
		--				mapping = cmp.mapping.preset.insert({
		--					["<Tab>"] = cmp.mapping.confirm({ select = true }),
		--					["<C-b>"] = cmp.mapping.scroll_docs(-4),
		--					["<C-f>"] = cmp.mapping.scroll_docs(4),
		--					["<C-Space>"] = cmp.mapping.complete(),
		--					["<CR>"] = cmp.mapping.confirm({ select = true }),
		--				}),
		--				sources = cmp.config.sources({
		--					{ name = "obsidian", priority = 1000 },
		--					{ name = "obsidian_new" },
		--					{ name = "nvim_lsp" },
		--					{ name = "luasnip" },
		--					{ name = "path" },
		--					{ name = "buffer" },
		--					{
		--						name = "cmdline",
		--						option = {
		--							ignore_cmds = { "Man", "!" },
		--						},
		--					},
		--				}),
		--			})
		--
		--			cmp.setup.cmdline(":", {
		--				mapping = cmp.mapping.preset.cmdline(),
		--				sources = {
		--					{ name = "path" },
		--					{ name = "cmdline" },
		--				},
		--				completion = {
		--					autocomplete = { require("cmp.types").cmp.TriggerEvent.TextChanged }, -- popup as you type
		--				},
		--			})
		--		end,
	},

	{ "mfussenegger/nvim-jdtls" },
}
