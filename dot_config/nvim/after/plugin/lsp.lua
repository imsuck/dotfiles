local lsp = require("lsp-zero")
local cmp = require("cmp")

lsp.preset("recommended")

lsp.on_attach(function(_, bufnr)
  lsp.default_keymaps({
    buffer = bufnr,
  })
end)

require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

cmp.setup({
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
  }
})

lsp.setup()
