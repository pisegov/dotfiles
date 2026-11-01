require("lsp-format").setup {}

require("lspconfig").lua_ls.setup {
    on_attach = require("lsp-format").on_attach,
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

vim.lsp.config("kotlin_lsp", {
    cmd = { "kotlin-lsp", "--stdio" },
    single_file_support = false,
    on_attach = require("lsp-format").on_attach,
})

vim.lsp.enable("kotlin_lsp")
