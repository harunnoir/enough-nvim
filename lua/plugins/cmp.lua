return {
    {
        'saghen/blink.cmp',
        version = '1.*',
        event = 'InsertEnter',
        dependencies = {
            'rafamadriz/friendly-snippets',
            'archie-judd/blink-cmp-words',
        },
        opts = {
            keymap = {
                preset = 'default',
                ['<C-space>'] = {
                    function(cmp)
                        if cmp.is_menu_visible() then
                            cmp.hide()
                        else
                            cmp.show()
                        end
                    end,
                    'show_documentation',
                    'hide_documentation',
                },
            },
            completion = {
                ghost_text = { enabled = true },
                menu = {
                    auto_show = true,
                    border = 'rounded',
                    draw = {
                        columns = {
                            { 'kind_icon', 'kind', gap = 2 },
                            { 'label', 'label_description' },
                        },
                    },
                },
                documentation = {
                    auto_show = true,
                    window = { border = 'rounded' },
                },
            },
            signature = {
                enabled = true,
                window = { border = 'rounded' },
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
                providers = {
                    thesaurus = {
                        name = 'blink-cmp-words',
                        module = 'blink-cmp-words.thesaurus',
                        opts = {
                            score_offset = 0,
                            definition_pointers = { '!', '&', '^' },
                            similarity_pointers = { '&', '^' },
                            similarity_depth = 2,
                        },
                    },
                    dictionary = {
                        name = 'blink-cmp-words',
                        module = 'blink-cmp-words.dictionary',
                        opts = {
                            dictionary_search_threshold = 3,
                            score_offset = 0,
                            definition_pointers = { '!', '&', '^' },
                        },
                    },
                },
                per_filetype = {
                    text = { 'lsp', 'path', 'snippets', 'buffer', 'dictionary' },
                    markdown = { 'lsp', 'path', 'snippets', 'buffer', 'thesaurus' },
                },
            },
        },
    },
}
