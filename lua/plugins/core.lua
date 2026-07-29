return {
    -- Treesitter: syntax highlighting, folds, text objects
    {
        'nvim-treesitter/nvim-treesitter',
        event = 'VeryLazy',
        build = ':TSUpdate',
        config = function()
            local patterns = {
                'bash',
                'c',
                'comment',
                'cpp',
                'css',
                'diff',
                'dockerfile',
                'elixir',
                'git_config',
                'gitcommit',
                'gitignore',
                'groovy',
                'go',
                'heex',
                'hcl',
                'html',
                'http',
                'java',
                'javascript',
                'jsdoc',
                'json',
                'json5',
                'lua',
                'make',
                'markdown',
                'markdown_inline',
                'python',
                'regex',
                'rst',
                'rust',
                'scss',
                'ssh_config',
                'sql',
                'terraform',
                'typst',
                'toml',
                'tsx',
                'typescript',
                'vim',
                'vimdoc',
                'yaml',
            }
            vim.treesitter.language.register('groovy', 'Jenkinsfile')
            vim.wo[0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
            vim.wo[0].foldmethod = 'expr'
            vim.api.nvim_create_autocmd('FileType', {
                pattern = patterns,
                callback = function() pcall(vim.treesitter.start) end,
            })
        end,
    },

    {
        'kevinhwang91/nvim-ufo',
        event = 'VeryLazy',
        dependencies = 'kevinhwang91/promise-async',
        keys = {
            { 'zR', function() require('ufo').openAllFolds() end, desc = 'Open all folds' },
            { 'zM', function() require('ufo').closeAllFolds() end, desc = 'Close all folds' },
        },
        config = function()
            vim.o.foldcolumn = '1'
            vim.o.foldlevel = 99
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true
            require('ufo').setup({
                provider_selector = function() return { 'treesitter', 'indent' } end,
            })
        end,
    },
}
