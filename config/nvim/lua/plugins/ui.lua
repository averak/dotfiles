return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = { theme = "material" },
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = { 'branch' },
                    lualine_c = {
                        {
                            'filename',
                            path = 1
                        }
                    },
                    lualine_x = { 'encoding', 'fileformat', 'filetype' },
                    lualine_y = { 'progress' },
                    lualine_z = { 'location' }
                },
                tabline = {
                    lualine_a = { 'buffers' },
                    lualine_b = {
                        {
                            'tabs',
                            mode = 2
                        }
                    },
                    lualine_c = {
                        {
                            function()
                                -- 現在のバッファのファイルパスを表示
                                return vim.fn.expand('%:~:.')
                            end
                        }
                    }
                },
            })
        end,
    },
    {
        "folke/noice.nvim",
        lazy = true,
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        config = function()
            require("noice").setup({
                lsp = {
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    },
                },
                presets = {
                    bottom_search = true,
                    command_palette = true,
                    long_message_to_split = true,
                    inc_rename = false,
                    lsp_doc_border = false,
                },
                views = {
                    cmdline_popup = {
                        position = {
                            row = "50%",
                            col = "50%",
                        },
                    },
                },
            })
        end,
    },
    {
        "petertriho/nvim-scrollbar",
        lazy = true,
        event = { "BufNewFile", "BufReadPre" },
        config = true,
    },
    {
        'numToStr/Comment.nvim',
        lazy = true,
        event = { "InsertEnter" },
        config = function()
            require('Comment').setup({
                toggler = {
                    line = 'cc',
                    block = 'cb',
                },
                opleader = {
                    line = 'cc',
                    block = 'cb',
                },
            })
        end
    }
}
