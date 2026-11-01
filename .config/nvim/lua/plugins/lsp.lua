local lsp_format = require("lsp-format")
lsp_format.setup {}

vim.lsp.config("lua_ls", {
    on_attach = lsp_format.on_attach,
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})

vim.lsp.config("ltex", {
    settings = {
        ltex = {
            language = "en-US",
            additionalRules = {
                motherTongue = "en-US"
            }
        }
    }
})

vim.lsp.config("kotlin_lsp", {
    cmd = { "kotlin-lsp", "--stdio" },
    workspace_required = true,
    on_attach = lsp_format.on_attach,
})

vim.lsp.enable({ "lua_ls", "ltex", "kotlin_lsp" })
