-- lua/plugins/ui.lua
return {
	-- Pretty statusline
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = { "filename" },
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
			})
		end,
	},

	-- Theme (easy dark theme)
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({ flavour = "mocha" }) -- Change to "latte" for light
		end,
	},

	-- Command line in popup (wilder.nvim or Noice for full cmd popup)
	-- Simple enhancement: use folke/noice.nvim for beautiful cmdline popup
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		--		event = { "InsertEnter", "CmdLineEnter" },
		lazy = false,
		{
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
		opts = {
			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
				},
			},

			-- you can enable a preset for easier configuration
			presets = {
				bottom_search = true, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = false, -- add a border to hover docs and signature help
			},
			views = {
				cmdline_popup = {
					border = {
						style = "none",
						padding = { 2, 3 },
					},
					filter_options = {},
					win_options = {
						winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
					},
				},
				--				cmdline_popup = {
				--					position = {
				--						row = 5,
				--						col = "50%",
				--					},
				--					size = {
				--						width = 60,
				--						height = "auto",
				--					},
				--				},
				--				popupmenu = {
				--					enabled = true, -- enables the Noice popupmenu UI
				--					backend = "cmp", -- backend to use to show regular cmdline completions
				--					relative = "editor",
				--					position = {
				--						row = 8,
				--						col = "50%",
				--					},
				--					size = {
				--						width = 60,
				--						height = 10,
				--					},
				--					border = {
				--						style = "rounded",
				--						padding = { 0, 1 },
				--					},
				--					win_options = {
				--						winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
				--					},
				--				},
			},
		},
	},
}
