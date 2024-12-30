return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        lazy = true,
        keys = {
            { "O",          ":Telescope find_files<CR>", desc = "Telescope find files" },
            { "F",          ":Telescope live_grep<CR>",  desc = "Telescope live grep" },
            { "<leader>th", ":Telescope help_tags<CR>",  desc = "Telescope help tags" },
        },
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
