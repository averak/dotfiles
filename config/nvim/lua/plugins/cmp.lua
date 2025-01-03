return {
	{
		"zbirenbaum/copilot.lua",
		lazy = true,
		event = { "InsertEnter" },
		config = function()
			require("copilot").setup({
				suggestion = {
					enabled = true,
					auto_trigger = true,
					keymap = {
						accept = "<Tab>",
					},
				},
				panel = { enabled = false },
				filetypes = {
					["*"] = true,
				},
			})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
			"L3MON4D3/LuaSnip",
			"onsails/lspkind-nvim",
		},
		lazy = true,
		event = { "InsertEnter" },
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
					{ name = "luasnip" },
				}),
				formatting = {
					format = require("lspkind").cmp_format({
						preset = "codicons",
					}),
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = true,
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			vim.keymap.set("n", "B", vim.lsp.buf.definition, { noremap = true, silent = true })
			vim.keymap.set("n", "D", vim.lsp.buf.declaration, { noremap = true, silent = true })
			vim.keymap.set("n", "I", vim.lsp.buf.implementation, { noremap = true, silent = true })
			vim.keymap.set("n", "U", vim.lsp.buf.references, { noremap = true, silent = true })
			vim.keymap.set("n", "R", vim.lsp.buf.rename, { noremap = true, silent = true })
			vim.keymap.set("n", "K", vim.lsp.buf.hover, { noremap = true, silent = true })
			vim.keymap.set("n", "<M-CR>", vim.lsp.buf.code_action, { noremap = true, silent = true })
		end,
	},
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"jay-babu/mason-null-ls.nvim",
			"nvimtools/none-ls.nvim",
		},
		lazy = true,
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("mason").setup()

			require("mason-lspconfig").setup({
				ensure_installed = {
					"gopls",
				},
			})
			require("mason-lspconfig").setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({})
				end,
			})

			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					-- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md
					null_ls.builtins.code_actions.gitsigns,
					null_ls.builtins.diagnostics.codespell,
					null_ls.builtins.diagnostics.todo_comments,
					null_ls.builtins.diagnostics.trail_space,

					null_ls.builtins.formatting.prettier,
					null_ls.builtins.formatting.gofumpt,
					null_ls.builtins.formatting.goimports,
					null_ls.builtins.diagnostics.golangci_lint,
					null_ls.builtins.diagnostics.buf,
					null_ls.builtins.formatting.buf,
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.diagnostics.yamllint,
					null_ls.builtins.diagnostics.actionlint,
				},
			})
			require("mason-null-ls").setup({
				ensure_installed = nil,
				automatic_installation = true,
			})
		end,
	},
}
