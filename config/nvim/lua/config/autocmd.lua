-- タイトルバーにファイル名を表示する。
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    callback = function()
        vim.opt.titlestring = vim.fn.expand("%:p")
        vim.opt.title = true
    end,
})

-- ファイルに変更があった場合に、自動で再読み込みする。
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained" }, {
    pattern = "*",
    command = "checktime",
})

-- ファイル保存時に code formatter を実行する。
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    vim.lsp.buf.format()
  end,
})
