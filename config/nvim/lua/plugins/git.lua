return {
    {
        "lewis6991/gitsigns.nvim",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
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
