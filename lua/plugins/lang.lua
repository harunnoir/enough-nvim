return {
    {
        'benomahony/uv.nvim',
        ft = 'python',
        opts = {
            picker_integration = true,
        },
    },
    -- Render-markdown: WYSIWYG markdown preview
    {
        'MeanderingProgrammer/render-markdown.nvim',
        event = 'VeryLazy',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },
        opts = {
            heading = {
                position = 'overlay',
                width = 'block',
                border = false,
                left_pad = 1,
                right_pad = 1,
            },
            code = {
                border = 'hide',
                position = 'left',
                width = 'full',
                left_pad = 1,
            },
            dash = { width = 'full' },
            quote = { icon = '▋' },
        },
    },
}
