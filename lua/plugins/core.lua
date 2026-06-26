return {
  -- Treesitter: syntax highlighting, folds, text objects
  {
    'nvim-treesitter/nvim-treesitter',
    event = 'VeryLazy',
    build = ':TSUpdate',
    config = function()
      local patterns = {
        'bash',
        'comment',
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
        callback = function() vim.treesitter.start() end,
      })
    end,
  },
  -- Ufo: better folds (treesitter + indent)
  {
    'kevinhwang91/nvim-ufo',
    event = 'VeryLazy',
    dependencies = 'kevinhwang91/promise-async',
    config = function()
      vim.o.foldcolumn = '1'
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

      require('ufo').setup({
        provider_selector = function() return { 'treesitter', 'indent' } end,
      })
    end,
  },
}
