return {
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",

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
        },
        config = function()
            require('nvim-treesitter.configs').setup({
                ensure_installed = { "go", "lua", "vim", "regex" },
                highlight = {
                    enable = true,
                },
                indent = {
                    enable = true,
                },
            })

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
                        attach = "a",
                        jumpto = "B",
                        help = "?",

                        -- 使わないものには `_` を指定する。
                        -- 使えるとベターなのかもしれないが、使いこなすのが難しそうなのでシンプルな設定にしておく。
                        watch = "_",
                        clear_marked = "_",
                        run_marked = "_",
                        mark = "_",
                        short = "_",
                        expand_all = "_",
                        clear_target = "_",
                        debug_marked = "_",
                        next_failed = "_",
                        target = "_",
                        debug = "_",
                    },
                },
            })
        end,
    }
}
