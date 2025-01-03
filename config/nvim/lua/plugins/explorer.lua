return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
		},
		lazy = true,
		opts = {
			pickers = {
				find_files = {
					find_command = {
						"rg",
						"--files",
						"--ignore",
						"--hidden",
						"-g",
						"!**/.git/*",
					},
				},
			},
		},
		keys = {
			{
				"O",
				function()
					require("telescope.builtin").find_files()
				end,
				desc = "Telescope find files",
			},
			{
				"F",
				function()
					require("telescope.builtin").live_grep()
				end,
				desc = "Telescope live grep",
			},
			{
				",,",
				function()
					require("telescope.builtin").help_tags()
				end,
				desc = "Telescope help tags",
			},
		},
		config = function()
			require("telescope").load_extension("ui-select")
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = true,
		keys = {
			{
				"<leader>e",
				function()
					require("nvim-tree.api").tree.toggle()
				end,
				desc = "Toggle NvimTree",
			},
		},
		config = function()
			require("nvim-tree").setup({
				git = {
					ignore = false,
				},
				filters = {
					dotfiles = false,
				},
			})
		end,
	},
}
