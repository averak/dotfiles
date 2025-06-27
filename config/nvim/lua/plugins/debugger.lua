return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"leoluz/nvim-dap-go",
			"mason-org/mason.nvim",
			"jay-babu/mason-nvim-dap.nvim",
		},
		keys = {
			{
				",b",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Debug toggle breakpoint",
			},
			{
				",B",
				function()
					require("dap").clear_breakpoints()
				end,
				desc = "Debug clear breakpoints",
			},
			{
				",e",
				function()
					require("dapui").toggle()
				end,
				desc = "Debug open ui",
			},
			{
				",K",
				function()
					require("dap.ui.widgets").hover()
				end,
				desc = "Debug hover",
			},
		},
		config = function()
			require("dapui").setup({
				mappings = {
					-- 干渉するキーは、無効化する。
					-- 必要な機能なら、適宜別のキーを割り当てること。
					toggle = "<Nop>",
				},
			})
			require("dap-go").setup()
			require("mason-nvim-dap").setup({
				ensure_installed = {
					"delve",
				},
			})

			vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#993939", bg = "#27292b" })
			vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0, fg = "#61afef", bg = "#27292b" })
			vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, fg = "#98c379", bg = "#27292b" })
			vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" })
			vim.fn.sign_define("DapBreakpointCondition", { text = "ﳁ", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" })
			vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" })
			vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint" })
			vim.fn.sign_define("DapStopped", {
				text = "",
				texthl = "DapStopped",
				linehl = "DapStopped",
				numhl = "DapStopped",
			})
		end,
	},
}
