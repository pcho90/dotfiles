local function prequire(module)
  local ok, lib = pcall(require, module)
  if ok then return lib end

  vim.notify(string.format('~ %s Call Error!', module))
end

local telescope = prequire 'telescope'
local actions = prequire 'telescope.actions'

telescope.setup {
  defaults = {
    sorting_strategy = 'ascending',
    layout_strategy = 'flex',
    layout_config = {
      prompt_position = 'top',
    },
    color_devicons = true,
    mappings = {
    i = {
      ['<C-j>'] = actions.move_selection_next,
      ['<C-k>'] = actions.move_selection_previous,
    }
    },
    file_ignore_patterns = { '^.git/', '^node_modules/' },
  },

  pickers = {
    find_files = {
      hidden = true,
    },
  },

  extensions = {
    file_browser = {
      initial_mode = 'normal',
      hidden = true,
    },
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
    },
  },
}

telescope.load_extension 'file_browser'
telescope.load_extension 'fzy_native'

local map_tele = function(before, after, type, opts)
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

map_tele('<space>tr', 'resume', 'builtin')
-- File Pickers
map_tele('<space>ff', 'find_files', 'builtin')
map_tele('<space>fe', 'file_browser.file_browser', 'extensions')
map_tele('<space>fw', 'grep_string', 'builtin')
map_tele('<space>fg', 'live_grep', 'builtin')
map_tele('<space>fz', 'current_buffer_fuzzy_find', 'builtin')
-- Vim Pickers
map_tele('<space>fb', 'buffers', 'builtin')
map_tele('<space>fr', 'registers', 'builtin')
map_tele('<space>fj', 'jumplist', 'builtin')
map_tele('<space>fh', 'oldfiles', 'builtin')
map_tele('<space>fx', 'command_history', 'builtin')
map_tele('<space>fc', 'commands', 'builtin')
map_tele('<space>fk', 'keymaps', 'builtin')
-- Neovim LSP Pickers
map_tele('gd', 'lsp_definitions', 'builtin')
map_tele('gr', 'lsp_references', 'builtin')
map_tele('<space>fs', 'lsp_document_symbols', 'builtin')
map_tele('<space>fa', 'lsp_code_actions', 'builtin')
map_tele('<space>fi', 'lsp_implementations', 'builtin')
map_tele('<space>ft', 'lsp_type_definitions', 'builtin')
-- Git Pickers
map_tele('<space>gf', 'git_files', 'builtin')
map_tele('<space>gs', 'git_status', 'builtin')
map_tele('<space>gc', 'git_commits', 'builtin')
map_tele('<space>gb', 'git_branches', 'builtin')
