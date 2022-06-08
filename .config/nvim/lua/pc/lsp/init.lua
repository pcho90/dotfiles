local ok, _ = pcall(require, "lspconfig")
if not ok then
  vim.notify('~ LSP Config Call Error!')
  return
end

require 'pc.lsp.lsp-installer'
require 'pc.lsp.handlers'.setup()
require 'pc.lsp.null-ls'

