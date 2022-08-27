local coq = require('coq')
local saga = require('lspsaga')

saga.init_lsp_saga()

local on_attach = function(client, bufnr)
  -- Mappings.
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', ':Declarations<CR>', bufopts)
  vim.keymap.set('n', 'gd', ':Definitions<CR>', bufopts)
  vim.keymap.set('n', 'gr', ':References<CR>', bufopts)
  vim.keymap.set('n', 'gi', ':Implementations<CR>', bufopts)
  vim.keymap.set('n', 'gn', ':Lspsaga diagnostic_jump_next<CR>', bufopts)
  vim.keymap.set('n', 'gp', ':Lspsaga diagnostic_jump_prev<CR>', bufopts)
  vim.keymap.set('n', 'gf', ':Lspsaga code_action<CR>', bufopts)
  vim.keymap.set('v', 'gf', ':<C-U>Lspsaga range_code_action<CR>', { silent = true })
  vim.keymap.set('n', 'pd', '<cmd>Lspsaga preview_definition<CR>', { silent = true })
  vim.keymap.set('n', ',', ':Lspsaga hover_doc<CR>', { silent = true })
end

require("lsp-inlayhints").setup()

require('lsp_signature').setup({
  handler_opts = { border = 'single' },
  floating_window = false,
  hint_prefix = ' ',
  hint_scheme = 'Comment',
  select_signature_key = '<C-n>',
})


require('lspconfig').clangd.setup(coq.lsp_ensure_capabilities({
  single_file_mode = false,
  cmd = { 'clangd-wrapper', '--background-index', '-j', '6', '--clang-tidy', '--clang-tidy-checks=modernize-*,-modernize-use-trailing-return-type', '--limit-results=0' },
  on_attach = on_attach,
}))

require('lspconfig').pyright.setup(coq.lsp_ensure_capabilities({
  on_attach = on_attach,
}))

require('fidget').setup()
