-- KEYBINDINGS
local function map(m, k, v)
    vim.keymap.set(m, k, v, { silent = true })
end

-- Better window navigation
map('n','<C-h>', '<C-w>h')
map('n','<C-j>', '<C-w>j')
map('n','<C-k>', "<C-w>k")
map('n','<C-l>', '<C-w>l')

-- Resize with arrows
map("n", "<C-Up>", ":resize +2<CR>")
map("n", "<C-Down>", ":resize -2<CR>")
map("n", "<C-Left>", ":vertical resize -2<CR>")
map("n", "<C-Right>", ":vertical resize +2<CR>")

-- Visual --
-- Stay in indent mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Move text up and down
map("v", "<A-j>", ":m .+1<CR>==")
map("v", "<A-k>", ":m .-2<CR>==")
map("v", "p", '"_dP')

-- Visual Block --
-- Move text up and down
map("x", "<A-j>", ":move '>+1<CR>gv-gv")
map("x", "<A-k>", ":move '<-2<CR>gv-gv")


map("n", "<leader>ff", ":Telescope find_files<CR>")
map("n", "<leader>fg", ":Telescope live_grep<CR>")

-- Mimic shell movements
map('', 'j', 'gj')
map('', 'k', 'gk')
map('n', 'Ж', ':! echo \"local beautiful = require(\'beautiful\'); beautiful.kbdcfg.switch_next()\" <bar> awesome-client<CR> | :')

map('n', 'K', '{')
map('n', 'J', '}')
map('n', 'H', '^')
map('n', 'L', '$')

map('n', 'Л', '{')
map('n', 'О', '}')
map('n', 'Р', '^')
map('n', 'Д', '$')

map('v', 'K', '{')
map('v', 'J', '}')
map('v', 'H', '^')
map('v', 'L', '$')

map('v', 'Л', '{')
map('v', 'О', '}')
map('v', 'Р', '^')
map('v', 'Д', '$')


-- map('n', '<C-x>', ':bp<Bar>bd #<Cr>')

map('i', '<C-k>', '<Up>')
map('i', '<C-j>', '<Down>')
map('i', '<C-h>', '<Left>')
map('i', '<C-l>', '<Right>')

map('n', '<C-c>', '"*y')
map('i', '<C-c>', '"*y')

map('i', 'jk', '<esc>')

map('n', 'gn', ':bn<cr>')
map('n', 'gp', ':bp<cr>')
map('n', 'gw', ':Bclose<cr>')

map('n', '<C-t>', ':NERDTreeToggle<CR>')
map('i', '<C-t>', ':NERDTreeToggle<CR>')

map('', '<C-/>', ':Commentary<CR>')
map('i', '<C-H>', '<C-W>')

vim.cmd('autocmd FileType tex map <Leader>s :w<CR> :!xelatex % <CR><CR>')
vim.cmd('autocmd FileType tex map <Leader>ы :w<CR> :!xelatex % <CR><CR>')
vim.cmd('autocmd FileType tex map <Leader>b :w<CR> :!xelatex % && bibtex %:r.aux && xelatex % && xelatex %<CR>')
vim.cmd('autocmd FileType tex map <Leader>и :w<CR><CR> :!xelatex % && bibtex %:r.aux && xelatex % && xelatex %<CR><CR>')

vim.cmd('autocmd FileType kotlin setlocal commentstring=//%s')

-- vim.cmd('inoremap <expr> <TAB> pumvisible() ? "<C-n>" : "<TAB>"')
