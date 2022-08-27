local saga = require('lspsaga')
local cmp = require('cmp')

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

cmp.setup({
    snippet = {
      expand = function(args)
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
    }, {
      { name = 'buffer' },
    })
})

cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

require('lsp-inlayhints').setup()

require('lsp_signature').setup({
  handler_opts = { border = 'single' },
  floating_window = false,
  hint_prefix = ' ',
  hint_scheme = 'Comment',
  select_signature_key = '<C-n>',
})

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
require('lspconfig').clangd.setup({
  single_file_mode = false,
  capabilities = capabilities,
  cmd = { 'clangd-wrapper', '--background-index', '-j', '6', '--clang-tidy', '--clang-tidy-checks=modernize-*,-modernize-use-trailing-return-type', '--limit-results=0' },
  on_attach = on_attach,
})

require('lspconfig').pyright.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

require('fidget').setup()
