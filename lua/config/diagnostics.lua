vim.diagnostic.config({
    signs = {
        text = {
            ERROR = '',
            WARN = '',
            HINT = '',
            INFO = '',
        },
    },
})

vim.lsp.inlay_hint.enable(true)
