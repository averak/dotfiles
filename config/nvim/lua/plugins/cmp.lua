return {
    {
        "github/copilot.vim",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
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
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            lspconfig.typos_lsp.setup({})
            lspconfig.gopls.setup({})

            vim.keymap.set("n", "B", vim.lsp.buf.definition, { noremap = true, silent = true })
            vim.keymap.set("n", "D", vim.lsp.buf.declaration, { noremap = true, silent = true })
            vim.keymap.set("n", "I", vim.lsp.buf.implementation, { noremap = true, silent = true })
            vim.keymap.set("n", "U", vim.lsp.buf.references, { noremap = true, silent = true })
            vim.keymap.set("n", "R", vim.lsp.buf.rename, { noremap = true, silent = true })
            vim.keymap.set("n", "K", vim.lsp.buf.hover, { noremap = true, silent = true })
        end,
    },
    {
        "nvimtools/none-ls.nvim",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            local null_ls = require("null-ls")

            null_ls.setup({
                sources = {
                    -- 以下のドキュメントから、使用するソースを選択する。
                    -- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md

                    null_ls.builtins.completion.spell,
                    null_ls.builtins.formatting.prettier,
                    null_ls.builtins.formatting.gofmt,
                    null_ls.builtins.formatting.goimports,
                    null_ls.builtins.diagnostics.golangci_lint,
                    null_ls.builtins.diagnostics.buf,
                    null_ls.builtins.formatting.buf,
                    null_ls.builtins.formatting.stylua,
                },
            })
        end,
    },
}
