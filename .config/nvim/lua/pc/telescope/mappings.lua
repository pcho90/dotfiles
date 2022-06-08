local map_tele = function(before, after, type, opts)  -- type = 'builtin' | 'extensions' | etc...
  local options = { noremap = true, silent = true }

  local rhs = ''
  if type == 'builtin' then
    rhs = string.format("<cmd>lua require('telescope.%s').%s()<CR>", type, after)
  elseif type == 'extensions' then
    rhs = string.format("<cmd>lua require('telescope').%s.%s()<CR>", type, after)
  else
    vim.notify('~ Invalid Type')
  end

  options = vim.tbl_deep_extend('force', options, opts or {})
  vim.api.nvim_set_keymap('n', before, rhs, options)
end

map_tele('<space>rr', 'resume', 'builtin')

-- File Pickers
map_tele('<space>ff', 'find_files', 'builtin')
map_tele('<space>bb', 'file_browser.file_browser', 'extensions')

map_tele('<space>gr', 'grep_string', 'builtin')
map_tele('<space>ll', 'live_grep', 'builtin')
map_tele('<space>bf', 'current_buffer_fuzzy_find', 'builtin')

-- Vim Pickers
map_tele('<space>bu', 'buffers', 'builtin')
map_tele('<space>re', 'registers', 'builtin')
map_tele('<space>ju', 'jumplist', 'builtin')

map_tele('<space>to', 'oldfiles', 'builtin')
map_tele('<space>th', 'help_tags', 'builtin')
map_tele('<space>tr', 'command_history', 'builtin')
map_tele('<space>tc', 'commands', 'builtin')
map_tele('<space>tk', 'keymaps', 'builtin')

-- Neovim LSP Pickers
-- map_tele('<space>lr', 'lsp_references', 'builtin')
map_tele('<F12>', 'lsp_references', 'builtin')
map_tele('<space>ls', 'lsp_document_symbols', 'builtin')
map_tele('<space>la', 'lsp_code_actions', 'builtin')
-- map_tele('<space>li', 'lsp_implementations', 'builtin)
-- map_tele('<space>ld', 'lsp_type_definitions', 'builtin)

-- Git Pickers
map_tele('<space>gf', 'git_files', 'builtin')
map_tele('<space>gs', 'git_status', 'builtin')
map_tele('<space>gc', 'git_commits', 'builtin')
map_tele('<space>gb', 'git_branchs', 'builtin')

-- Treesitter Picker
map_tele('<space>ts', 'treesitter', 'builtin')

-- Lists Pickers
map_tele('<space>tb', 'builtin', 'builtin')
map_tele('<space>tl', 'reloader', 'builtin')

