return {
	{
		"lewis6991/gitsigns.nvim",
		lazy = true,
		event = { "BufReadPost", "BufNewFile" },
		keys = {
			{
				"gd",
				function()
					require("gitsigns").preview_hunk()
				end,
				desc = "Git diff",
			},
			{
				"gb",
				function()
					require("gitsigns").blame_line()
				end,
				desc = "Git blame",
			},
		},
		config = true,
	},
	{
		"mikinovation/nvim-gitui",
		lazy = true,
		keys = {
			{
				"<leader>gu",
				function()
					require("nvim-gitui").open_gitui()
				end,
				desc = "Gitui",
			},
		},
	},
	{
		"kdheepak/lazygit.nvim",
		lazy = true,
		keys = {
			{
				"<leader>lg",
				function()
					vim.cmd("LazyGit")
				end,
				desc = "LazyGit",
			},
		},
	},
}
