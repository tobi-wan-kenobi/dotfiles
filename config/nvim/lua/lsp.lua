local coq = require('coq')

local on_attach = function(client, bufnr)
  -- Mappings.
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', ':Declarations<CR>', bufopts)
  vim.keymap.set('n', 'gd', ':Definitions<CR>', bufopts)
  vim.keymap.set('n', 'gr', ':References<CR>', bufopts)
  vim.keymap.set('n', 'gi', ':Implementations<CR>', bufopts)
  vim.keymap.set('n', 'gn', vim.diagnostic.goto_next, bufopts)
  vim.keymap.set('n', 'gp', vim.diagnostic.goto_prev, bufopts)
  vim.keymap.set('n', 'gc', ':CodeActions<CR>', bufopts)
  vim.keymap.set('n', 'gf', ':CodeActions<CR>', bufopts)
  vim.keymap.set('n',  'K', require('hover').hover       , { desc='hover.nvim'         })

end

require('lspconfig').clangd.setup(coq.lsp_ensure_capabilities({
  single_file_mode = false,
  cmd = { 'clangd-wrapper', '--background-index', '-j', '6', '--clang-tidy', '--clang-tidy-checks=modernize-*,-modernize-use-trailing-return-type', '--limit-results=0' },
  on_attach = on_attach,
}))

require('lspconfig').pyright.setup(coq.lsp_ensure_capabilities({
  on_attach = on_attach,
}))

require('fidget').setup()
