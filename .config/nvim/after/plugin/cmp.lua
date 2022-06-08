local function prequire(module)
  local ok, lib = pcall(require, module)
  if ok then return lib end

  vim.notify('~ ' .. module .. ' Call Error!')
end

local cmp = prequire("cmp")
local icons = prequire 'pc.icons'
local kind_icons = icons.kind

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
  preselect = 'none',
  -- preselect = cmp.PreselectMode.None,

  window = {
    -- documentation = { border = 'single' }
    documentation = {
      border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
    },
  },

  mapping = {
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    -- ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.close()
      else
        cmp.complete()
      end
    end, { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" }),
  },

  formatting = {
    fields = { 'kind', 'abbr', 'menu' },
    format = function(entry, vim_item)
      vim_item.kind = string.format('%s', kind_icons[vim_item.kind])
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        nvim_lua = "[NVIM_Lua]",
        buffer = "[Buffer]",
        path = '[Path]',
      })[entry.source.name]
      return vim_item
    end
  },

  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim-lua' },
  }, {
    { name = 'buffer' },
    { name = 'path' },
  }),

  confirm_opts = {
    select = false,
  },

  -- experimental = {
  --   ghost_text = true,
  --   --native_menu = false,
  -- },
})
