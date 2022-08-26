require('plugins')
require('lsp')
require('filetypes')
require('keybindings')

-- basic setup
vim.opt.number = true
vim.opt.mouse = 'nv'
vim.opt.cmdheight = 2
vim.opt.colorcolumn = '80'
vim.opt.cursorline = true

-- indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.fn.sign_define(
  'DiagnosticSignError',
  { text = '', texthl = 'LspDiagnosticsDefaultError' }
)

vim.fn.sign_define(
  'DiagnosticSignWarn',
  { text = '', texthl = 'LspDiagnosticsDefaultWarning' }
)

vim.fn.sign_define(
  'DiagnosticSignInfo',
  { text = '', texthl = 'LspDiagnosticsDefaultInformation' }
)

vim.fn.sign_define(
  'DiagnosticSignHint',
  { text = '', texthl = 'LspDiagnosticsDefaultHint' }
)

