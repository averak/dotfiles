return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",

			-- https://github.com/nvim-neotest/neotest?tab=readme-ov-file#supported-runners
			"nvim-neotest/neotest-go",
		},
		lazy = true,
		event = { "LspAttach" },
		keys = {
			{
				"<leader>tt",
				function()
					require("neotest").run.run()
					require("neotest").summary.open()
				end,
				desc = "Run test in cursor",
			},
			{
				"<leader>ta",
				function()
					require("neotest").run.run(vim.fn.expand("%"))
					require("neotest").summary.open()
				end,
				desc = "Run test in current file",
			},
			{
				"<leader>ts",
				function()
					require("neotest").summary.toggle()
				end,
				desc = "Toggle test summary",
			},
			{
				"<leader>td",
				function()
					require("neotest").run.run({ strategy = "dap" })
				end,
				desc = "Debug test in cursor",
			},
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-go")({
						args = { "-v" },
					}),
				},
				summary = {
					mappings = {
						expand = { "<CR>" },
						output = "o",
						run = "r",
						stop = "x",
						debug = "d",
						attach = "a",
						jumpto = "B",
						help = "?",

						-- 使わないものには Nop を割り当てる。
						-- 使えるとベターなのかもしれないが、使いこなすのが難しそうなのでシンプルな設定にしておく。
						watch = "<Nop>",
						clear_marked = "<Nop>",
						run_marked = "<Nop>",
						mark = "<Nop>",
						short = "<Nop>",
						expand_all = "<Nop>",
						clear_target = "<Nop>",
						debug_marked = "<Nop>",
						next_failed = "<Nop>",
						target = "<Nop>",
					},
				},
			})
		end,
	},
}
