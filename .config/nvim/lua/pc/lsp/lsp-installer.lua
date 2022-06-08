local ok, lsp_installer = pcall(require, 'nvim-lsp-installer')
if not ok then
  vim.notify('~ LSP Installer Call Error!')
  return
end

-- Include the servers you want to have installed by default below
 local servers = {
   'typescriptreact',
   'tsserver',
   'jsonls',
   'pyright',
   'sumneko_lua',
 }

for _, name in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found and not server:is_installed() then
    print("Installing " .. name)
    server:install()
  end
end

-- Register a handler that will be called for each installed server when it's ready (i.e. when installation is finished
-- or if the server is already installed).
lsp_installer.on_server_ready(function(server)
  local opts = {
    on_attach = require('pc.lsp.handlers').on_attach,
    capabilities = require('pc.lsp.handlers').capabilities,
  }

  -- (optional) Customize the options passed to the server
  -- if server.name == 'gopls' then
  --   local gopls_opts = require 'pc.lsp.settings.gopls'
  --   opts = vim.tbl_deep_extend('force', gopls_opts, opts)
  -- end

  if server.name == 'sumneko_lua' then
    local sumneko_opts = require 'pc.lsp.settings.sumneko_lua'
    opts = vim.tbl_deep_extend('force', sumneko_opts, opts)
  end

  -- if server.name == 'jsonls' then
  --   local jsonls_opts = require 'pc.lsp.settings.jsonls'
  --   opts = vim.tbl_deep_extend('force', jsonls_opts, opts)
  -- end

  -- if server.name == 'bashls' then
  --   local bashls_opts = require 'pc.lsp.settings.bashls'
  --   opts = vim.tbl_deep_extend('force', bashls_opts, opts)
  -- end

  --if server.name == "pyright" then
  --  local pyright_opts = require "user.lsp.settings.pyright"
  --  opts = vim.tbl_deep_extend("force", pyright_opts, opts)
  --end

  --if server.name == "emmet_ls" then
  --  local emmet_ls_opts = require "user.lsp.settings.emmet_ls"
  --  opts = vim.tbl_deep_extend("force", emmet_ls_opts, opts)
  --end

  -- This setup() function will take the provided server configuration and decorate it with the necessary properties
  -- before passing it onwards to lspconfig.
  -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(opts)
end)

