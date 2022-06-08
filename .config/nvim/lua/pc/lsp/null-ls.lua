local ok, null_ls = pcall(require, 'null-ls')
if not ok then
  vim.notify('~ null-ls Call Error!')
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup {
  sources = {
    formatting.black,
    formatting.stylua,
    diagnostics.zsh,
    code_actions.gitsigns,
    code_actions.eslint,
  },
}
