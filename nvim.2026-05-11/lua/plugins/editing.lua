-- lua/plugins/editing.lua
return {
	-- Surround (ysiw" etc. - very intuitive)
	{
		"nvim-mini/mini.surround", -- Modern Lua alternative to tpope/vim-surround
		lazy = false,
		version = "*",
		config = function()
			require("mini.surround").setup()
		end,
	},

	-- Todo comments highlight
	{
		"folke/todo-comments.nvim",
		lazy = false,
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("todo-comments").setup()
		end,
		-- :TodoTelescope or :TodoQuickFix to list
	},
}
