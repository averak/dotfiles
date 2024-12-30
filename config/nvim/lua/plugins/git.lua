return {
    {
        "lewis6991/gitsigns.nvim",
        config = true,
    },
    {
        "kdheepak/lazygit.nvim",
        lazy = true,
        keys = {
            {
                "<leader>lg",
                function()
                    vim.cmd("LazyGit")
                end,
                desc = "LazyGit",
            },
        },
    },
}
