return {
    {
        "easymotion/vim-easymotion",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            vim.api.nvim_set_keymap('n', '<Leader>w', '<Plug>(easymotion-bd-w)', {})
            vim.api.nvim_set_keymap('n', '<Leader>k', '<Plug>(easymotion-bd-f)', {})
            vim.api.nvim_set_keymap('n', '<Leader>l', '<Plug>(easymotion-bd-jk)', {})
        end,
    },
    {
        -- `%` で対応する括弧に移動する。
        "andymass/vim-matchup",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
    },
    {
        -- 括弧の片側を入力すると、対応する括弧が自動で挿入される。
        "cohama/lexima.vim",
        lazy = true,
        event = { "InsertEnter" },
    },
    {
        "alvan/vim-closetag",
        lazy = true,
        ft = { "html", "xhtml", "phtml", "jsx", "tsx" },
        config = function()
            vim.g.closetag_filenames = '*.html,*.xhtml,*.phtml,*.jsx,*.tsx'
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
            { "<Leader>go", ":QuickRun<CR>", desc = "QuickRun" },
        },
    },
    {
        "bronson/vim-trailing-whitespace",
    },
    {
        "LunarVim/bigfile.nvim",
        lazy = true,
        config = function()
            require("bigfile").setup {
                -- 1 MiB 以上のファイルを開いた場合に、いくつかの機能を無効化する。
                filesize = 1,
            }
        end,
    }
}
