return {
	{
		"nvim-treesitter/nvim-treesitter",
		-- master branch は archive 済みで、Neovim 0.12 では query の directive が動かない。
		branch = "main",
		-- main branch は lazy-load を想定していない。
		lazy = false,
		build = ":TSUpdate",
		config = function()
			local treesitter = require("nvim-treesitter")
			treesitter.setup()
			vim.treesitter.language.register("markdown", "mdx")

			---@type table<string, boolean>?
			local available

			-- 必要な parser を全て列挙するのは面倒なので、開いた filetype の parser をその場でインストールする。
			-- インストールは非同期なので、初回に開いた buffer だけは完了後に treesitter を起動し直す。
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					local lang = vim.treesitter.language.get_lang(args.match)
					if not lang then
						return
					end

					-- Neovim 本体が同梱するパーサー (markdown, lua, vim, vimdoc 等) は、Neovim のバージョンに合わせたクエリファイルとセットで提供されている。
					-- nvim-treesitter のインストール先は runtimepath の先頭に置かれて同梱版を隠すため、パーサーが既にある言語はインストールしない。
					-- ref: https://github.com/neovim/neovim/issues/34113
					if vim.treesitter.language.add(lang) then
						pcall(vim.treesitter.start, args.buf, lang)
						return
					end

					if not available then
						available = {}
						for _, name in ipairs(treesitter.get_available()) do
							available[name] = true
						end
					end
					-- 対応する parser がない言語を install に渡すと警告が出るため、ここで打ち切る。
					if not available[lang] then
						return
					end

					treesitter.install(lang):await(function(err)
						if err then
							return
						end
						vim.schedule(function()
							if vim.api.nvim_buf_is_valid(args.buf) then
								pcall(vim.treesitter.start, args.buf, lang)
							end
						end)
					end)
				end,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = { "BufNewFile", "BufReadPre" },
		config = function()
			require("treesitter-context").setup({
				enable = true,
				multiwindow = false,
				max_lines = 0,
				min_window_height = 0,
				line_numbers = true,
				multiline_threshold = 20,
				trim_scope = "outer",
				mode = "cursor",
				separator = nil,
				zindex = 20,
				on_attach = nil,
			})
		end,
	},
	{
		"easymotion/vim-easymotion",
		lazy = true,
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			vim.api.nvim_set_keymap("n", "<Leader>w", "<Plug>(easymotion-bd-w)", {})
			vim.api.nvim_set_keymap("n", "<Leader>k", "<Plug>(easymotion-bd-f)", {})
			vim.api.nvim_set_keymap("n", "<Leader>l", "<Plug>(easymotion-bd-jk)", {})
		end,
	},
	{
		-- `%` で対応する括弧に移動する。
		"andymass/vim-matchup",
		lazy = true,
		event = { "BufReadPost", "BufNewFile" },
	},
	{
		-- 括弧やクォートなどの片側を入力すると、対応するものも自動で入力される。
		"windwp/nvim-autopairs",
		lazy = true,
		event = { "InsertEnter" },
		config = true,
	},
	{
		"alvan/vim-closetag",
		lazy = true,
		event = { "InsertEnter" },
		ft = { "html", "xhtml", "phtml", "jsx", "tsx" },
		config = function()
			vim.g.closetag_filenames = "*.html,*.xhtml,*.phtml,*.jsx,*.tsx"
		end,
	},
	{
		-- カラーをプレビューする。
		"gorodinskiy/vim-coloresque",
		lazy = true,
		event = { "BufReadPost", "BufNewFile" },
	},
	{
		"thinca/vim-quickrun",
		lazy = true,
		keys = {
			{
				"<leader>go",
				function()
					vim.cmd(":QuickRun")
				end,
				desc = "QuickRun",
			},
		},
	},
	{
		"LunarVim/bigfile.nvim",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("bigfile").setup({
				-- 1 MiB 以上のファイルを開いた場合に、いくつかの機能を無効化する。
				filesize = 1,
			})
		end,
	},
	{
		"numToStr/Comment.nvim",
		lazy = true,
		event = { "InsertEnter" },
		config = function()
			require("Comment").setup({
				-- line comment: Alt + /
				-- block comment: Alt + Shift + /
				toggler = {
					line = "÷",
					block = "¿",
				},
				opleader = {
					line = "÷",
					block = "¿",
				},
			})
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		lazy = true,
		ft = { "markdown" },
		keys = {
			{
				"<leader>mp",
				function()
					vim.cmd(":MarkdownPreview")
				end,
				desc = "Markdown preview",
			},
		},
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	{
		"folke/trouble.nvim",
		lazy = true,
		keys = {
			{
				",x",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Trouble",
			},
		},
		config = true,
	},
}
