return {
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require('gitsigns').setup()
        end,
    },
    {
        "kdheepak/lazygit.nvim",
        lazy = true,
        keys = {
            { "<leader>lg", ":LazyGit<CR>", desc = "LazyGit" },
        },
    },
}
