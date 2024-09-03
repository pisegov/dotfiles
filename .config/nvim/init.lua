-- Config was built using the following config:
-- https://github.com/numToStr/dotfiles/tree/master/neovim/.config/nvim/
require('plugins')
local g   = vim.g
local o   = vim.o
local opt = vim.opt
local A   = vim.api

o.langmap = "ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz"

vim.cmd('syntax on')
vim.api.nvim_command('filetype plugin indent on')

o.termguicolors = true
-- o.background = 'dark'

-- Do not save when switching buffers
-- o.hidden = true

-- Decrease update time
o.timeoutlen = 500
o.updatetime = 200

-- Number of screen lines to keep above and below the cursor
o.scrolloff = 8

-- Better editor UI
o.number = true
o.numberwidth = 2
o.relativenumber = true
o.signcolumn = 'yes'
o.cursorline = true
vim.cmd(':set colorcolumn=79')

-- Better editing experience
o.expandtab = true
o.smarttab = true
o.cindent = true
o.autoindent = true
o.wrap = true
o.linebreak = true
o.textwidth = 80
o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = -1 -- If negative, shiftwidth value is used
o.list = true
o.listchars = 'trail:·,nbsp:◇,tab:→ ,extends:▸,precedes:◂'
-- o.listchars = 'eol:¬,space:·,lead: ,trail:·,nbsp:◇,tab:→-,extends:▸,precedes:◂,multispace:···⬝,leadmultispace:│   ,'
-- o.formatoptions = 'qrn1'

-- Makes neovim and host OS clipboard play nicely with each other
o.clipboard = 'unnamedplus'

-- Case insensitive searching UNLESS /C or capital in search
o.ignorecase = true
o.smartcase = true

-- Undo and backup options
o.backup = false
o.writebackup = false
o.undofile = true
o.swapfile = false
-- o.backupdir = '/tmp/'
-- o.directory = '/tmp/'
-- o.undodir = '/tmp/'

-- Remember 50 items in commandline history
o.history = 50

-- Better buffer splitting
o.splitright = true
o.splitbelow = true

-- Preserve view while jumping
-- BUG This option causes an error!
-- o.jumpoptions = 'view'

-- BUG: this won't update the search count after pressing `n` or `N`
-- When running macros and regexes on a large file, lazy redraw tells neovim/vim not to draw the screen
-- o.lazyredraw = true

-- Better folds (don't fold by default)
-- o.foldmethod = 'indent'
-- o.foldlevelstart = 99
-- o.foldnestmax = 3
-- o.foldminlines = 1
--

-- NERDTree dot files
vim.cmd(
    [[ let NERDTreeShowHidden = 1 ]]
)

opt.mouse = "a"

-- Map <leader> to space
g.mapleader = ' '
g.maplocalleader = ' '

require('lualine').setup {
  options = {
    theme = 'monokaipro'
  }
}
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "kotlin_language_server" }
})

require('nvim-treesitter.configs').setup({
    ensure_installed = {
        "c", -- Treesitter Parser for C
        "cpp", -- Treesitter Parser for C++
        "json",
        "javascript",
        "typescript",
        "yaml",
        "html",
        "css",
        "markdown",
        "markdown_inline",
        "bash",
        "lua",
        "vim",
        "dockerfile",
        "gitignore",
        "kotlin",
    },

    highlight = {
        enable = true,
    },

    indent = {
        enable = true
    },
})

vim.filetype.add({
  pattern = { [".*/hyprland%.conf"] = "hyprlang" },
})

-- COLORSCHEMES
-- Uncomment just ONE of the following colorschemes!
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-dracula')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-gruvbox-dark-medium')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-monokai')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-nord')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-oceanicnext')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-onedark')
-- local ok, _ = pcall(vim.cmd, 'colorscheme palenight')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-solarized-dark')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-solarized-light')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-tomorrow-night')

-- monokai pro colorscheme
vim.cmd[[colorscheme monokaipro]]


-- Highlight the region on yank
A.nvim_create_autocmd('TextYankPost', {
    group = num_au,
    callback = function()
        vim.highlight.on_yank({ higroup = 'Visual', timeout = 120 })
    end,
})

-- Telescope fzf
-- require('telescope').load_extension('fzf')


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

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- luasnip setup
local luasnip = require 'luasnip'

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- nvim-cmp setup
local cmp = require('cmp')

cmp.setup {
    completion = {
        -- autocomplete = false
    },
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        --     ['<Tab>'] = function(fallback)
        --       if vim.fn.pumvisible() == 1 then
        --         vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
        --       elseif luasnip.expand_or_jumpable() then
        --         vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
        --       else
        --         fallback()
        --       end
        --     end,
        --     ['<S-Tab>'] = function(fallback)
        --       if vim.fn.pumvisible() == 1 then
        --         vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
        --       elseif luasnip.jumpable(-1) then
        --         vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
        --       else
        --         fallback()
        --       end
        --     end,
    },
    ["<tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
        elseif has_words_before() then
            cmp.complete()
        else
            fallback()
        end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
        else
            fallback()
        end
    end, { "i", "s" }),
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },
}

local nvim_lsp = require('lspconfig')


-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', '<space>k', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>d', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

-- require("lspconfig").kotlin_language_server.setup {
--     on_attach = on_attach
-- }

require("lspconfig").lua_ls.setup {
    on_attach = on_attach,
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
}

require("lspconfig").ltex.setup {
    on_attach = on_attach,
    ltex = {
        settings = {
            language = "en-US"
        },
        additionalRules = {
            motherTongue = "en-US"
        }
    }
}


