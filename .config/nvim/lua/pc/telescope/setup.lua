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
