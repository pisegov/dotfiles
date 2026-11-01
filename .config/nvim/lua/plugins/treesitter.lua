local treesitter = require('nvim-treesitter')

-- Prepend the new parser directory so it wins over parsers from the old plugin.
treesitter.setup {
  install_dir = vim.fn.stdpath('data') .. '/site',
}

-- Installation is asynchronous and skips languages already installed.
-- Org is not in main's parser list; it needs a separately configured parser.
treesitter.install {
  'go', 'lua', 'python', 'rust', 'typescript', 'regex',
  'bash', 'markdown', 'markdown_inline', 'kdl', 'sql', 'terraform',
  'html', 'css', 'javascript', 'yaml', 'json', 'toml', 'kotlin',
}

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('UserTreesitter', { clear = true }),
  callback = function(event)
    local lang = vim.treesitter.language.get_lang(vim.bo[event.buf].filetype)
    if not lang then
      return
    end

    -- Files without an installed parser keep Neovim's normal highlighting.
    if pcall(vim.treesitter.start, event.buf, lang) then
      if vim.treesitter.query.get(lang, 'indents') then
        vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end
  end,
})

-- Neovim 0.12 provides node selection. The old scope_incremental action
-- on <C-s> has no direct equivalent and is deliberately not mapped here.
vim.keymap.set({ 'n', 'x' }, '<C-Space>', function()
  vim.treesitter.select('parent')
end, { desc = 'Expand Treesitter node selection' })

vim.keymap.set('x', '<C-BS>', function()
  vim.treesitter.select('child')
end, { desc = 'Shrink Treesitter node selection' })

require('nvim-treesitter-textobjects').setup {
  select = { lookahead = true },
  move = { set_jumps = true },
}

local selections = {
  aa = '@parameter.outer',
  ia = '@parameter.inner',
  af = '@function.outer',
  ['if'] = '@function.inner',
  ac = '@class.outer',
  ic = '@class.inner',
  ii = '@conditional.inner',
  ai = '@conditional.outer',
  il = '@loop.inner',
  al = '@loop.outer',
  at = '@comment.outer',
}

for lhs, capture in pairs(selections) do
  local query = capture
  vim.keymap.set({ 'x', 'o' }, lhs, function()
    require('nvim-treesitter-textobjects.select').select_textobject(query, 'textobjects')
  end, { desc = 'Select ' .. query })
end

local movements = {
  [']f'] = { 'goto_next_start', '@function.outer' },
  [']]'] = { 'goto_next_start', '@class.outer' },
  [']F'] = { 'goto_next_end', '@function.outer' },
  [']['] = { 'goto_next_end', '@class.outer' },
  ['[f'] = { 'goto_previous_start', '@function.outer' },
  ['[['] = { 'goto_previous_start', '@class.outer' },
  ['[F'] = { 'goto_previous_end', '@function.outer' },
  ['[]'] = { 'goto_previous_end', '@class.outer' },
}

for lhs, action in pairs(movements) do
  local method, query = action[1], action[2]
  vim.keymap.set({ 'n', 'x', 'o' }, lhs, function()
    require('nvim-treesitter-textobjects.move')[method](query, 'textobjects')
  end, { desc = method .. ' ' .. query })
end

vim.keymap.set('n', '<leader>a', function()
  require('nvim-treesitter-textobjects.swap').swap_next('@parameter.inner')
end, { desc = 'Swap parameter with next' })

vim.keymap.set('n', '<leader>A', function()
  require('nvim-treesitter-textobjects.swap').swap_previous('@parameter.inner')
end, { desc = 'Swap parameter with previous' })
