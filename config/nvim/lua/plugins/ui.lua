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
}
