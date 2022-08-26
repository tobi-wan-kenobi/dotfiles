local fterm = require('FTerm')

vim.keymap.set('n', 'bn', ':bn<CR>')
vim.keymap.set('n', 'bp', ':bp<CR>')
vim.keymap.set('n', 'bd', ':bd<CR>')
vim.keymap.set('n', 'tn', ':tabn<CR>')
vim.keymap.set('n', 'tp', ':tabp<CR>')

local fzf = require('fzf-lua')
vim.keymap.set('n', 'ff', fzf.files)
vim.keymap.set('n', 'fg', fzf.live_grep)
vim.keymap.set('n', 'fb', fzf.buffers)

vim.keymap.set('n', 'ee', ':NvimTreeToggle<CR>')

local ngbuild = fterm:new({ cmd = 'ngbuild' })
vim.keymap.set('n', '<leader>t', fterm.toggle)
vim.keymap.set('t', '<leader>t', fterm.toggle)
vim.keymap.set('n', '<leader>b', function() ngbuild:toggle() end)
vim.keymap.set('t', '<leader>b', function() ngbuild:toggle() end)

vim.keymap.set('n', '<leader>g', ':GitBlameToggle<CR>')
vim.keymap.set('n', '<leader>c', ':GitMessenger<CR>')
