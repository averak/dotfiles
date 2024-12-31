vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- support averak layout
-- https://raw.githubusercontent.com/averak/averak/master/assets/averak-keymap.png

vim.keymap.set({ 'n', 'v', 'o' }, 'h', 'h', { noremap = true, silent = true })
vim.keymap.set({ 'n', 'v', 'o' }, 't', 'j', { noremap = true, silent = true })
vim.keymap.set({ 'n', 'v', 'o' }, 'k', 'k', { noremap = true, silent = true })
vim.keymap.set({ 'n', 'v', 'o' }, 'n', 'l', { noremap = true, silent = true })

-- undo / redo
vim.api.nvim_set_keymap('n', 'u', 'u', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'r', '<C-r>', { noremap = true, silent = true })

-- go / return to word
vim.api.nvim_set_keymap('n', 'W', 'b', { noremap = true, silent = true })

-- scroll
vim.api.nvim_set_keymap('n', 'ok', '<C-u>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'ot', '<C-d>', { noremap = true, silent = true })

-- window
vim.api.nvim_set_keymap('n', '<Leader>s', ':<C-u>split<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>v', ':<C-u>vsplit<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<UP>', '<C-w>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Down>', '<C-w>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Left>', '<C-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Right>', '<C-w>l', { noremap = true, silent = true })

-- tab
vim.api.nvim_set_keymap('n', '<Leader>tab', ':tabnew<CR>', { noremap = true, silent = true })

-- terminal
vim.api.nvim_set_keymap('n', '<Leader>ter', ':vertical terminal<CR>', { noremap = true, silent = true })

-- move buffer
vim.api.nvim_set_keymap('n', '<Tab>', ':bn<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-Tab>', ':bp<CR>', { noremap = true, silent = true })

-- copy / delete
vim.api.nvim_set_keymap('n', '<Leader>yy', ':%y<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>dd', ':%d<CR>', { noremap = true, silent = true })

-- increment / decrement
vim.api.nvim_set_keymap('n', '+', '<C-a>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '-', '<C-x>', { noremap = true, silent = true })

-- edge of line
vim.api.nvim_set_keymap('n', 'N', '$', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'N', '$', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'H', '0', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'H', '0', { noremap = true, silent = true })

-- search
vim.api.nvim_set_keymap('n', '>', 'N', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'E', 'n', { noremap = true, silent = true })

-- absorb type
vim.api.nvim_command('command! -nargs=0 W :w')
vim.api.nvim_command('command! -nargs=0 Q :q')

vim.opt.runtimepath:append("~/.config/nvim")
