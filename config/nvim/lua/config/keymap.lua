vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- support averak layout
-- https://raw.githubusercontent.com/averak/averak/master/assets/averak-keymap.png

vim.api.nvim_set_keymap('n', 'h', 'h', { noremap = true })
vim.api.nvim_set_keymap('v', 'h', 'h', { noremap = true })
vim.api.nvim_set_keymap('n', 't', 'j', { noremap = true })
vim.api.nvim_set_keymap('v', 't', 'j', { noremap = true })
vim.api.nvim_set_keymap('n', 'k', 'k', { noremap = true })
vim.api.nvim_set_keymap('v', 'k', 'k', { noremap = true })
vim.api.nvim_set_keymap('n', 'n', 'l', { noremap = true })
vim.api.nvim_set_keymap('v', 'n', 'l', { noremap = true })

-- undo / redo
vim.api.nvim_set_keymap('n', 'U', '<C-r>', { noremap = true })

-- go / return to word
vim.api.nvim_set_keymap('n', 'W', 'b', { noremap = true })

-- scroll
vim.api.nvim_set_keymap('n', 'ok', '<C-u>', { noremap = true })
vim.api.nvim_set_keymap('n', 'ot', '<C-d>', { noremap = true })

-- window
vim.api.nvim_set_keymap('n', '<Leader>s', ':<C-u>split<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>v', ':<C-u>vsplit<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<UP>', '<C-w>k', { noremap = true })
vim.api.nvim_set_keymap('n', '<Down>', '<C-w>j', { noremap = true })
vim.api.nvim_set_keymap('n', '<Left>', '<C-w>h', { noremap = true })
vim.api.nvim_set_keymap('n', '<Right>', '<C-w>l', { noremap = true })

-- tab
vim.api.nvim_set_keymap('n', '<Leader>tab', ':tabnew<CR>', { noremap = true })

-- terminal
vim.api.nvim_set_keymap('n', '<Leader>ter', ':vertical terminal<CR>', { noremap = true })

-- move buffer
vim.api.nvim_set_keymap('n', '<Tab>', ':bn<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<S-Tab>', ':bp<CR>', { noremap = true })

-- copy / delete
vim.api.nvim_set_keymap('n', '<Leader>yy', ':%y<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>dd', ':%d<CR>', { noremap = true })

-- increment / decrement
vim.api.nvim_set_keymap('n', '+', '<C-a>', { noremap = true })
vim.api.nvim_set_keymap('n', '-', '<C-x>', { noremap = true })

-- edge of line
vim.api.nvim_set_keymap('n', 'N', '$', { noremap = true })
vim.api.nvim_set_keymap('v', 'N', '$', { noremap = true })
vim.api.nvim_set_keymap('n', 'H', '0', { noremap = true })
vim.api.nvim_set_keymap('v', 'H', '0', { noremap = true })

-- search
vim.api.nvim_set_keymap('n', '/', '/\\v', { noremap = true })
vim.api.nvim_set_keymap('n', 'K', 'N', { noremap = true })
vim.api.nvim_set_keymap('n', 'T', 'n', { noremap = true })

-- absorb type
vim.api.nvim_command('command! -nargs=0 W :w')
vim.api.nvim_command('command! -nargs=0 Q :q')
