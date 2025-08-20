return {
    {
        'saghen/blink.cmp',
        event = 'VimEnter',
        dependencies = {
            {
                'L3MON4D3/LuaSnip',
                version = 'v2.*',
                dependencies = {
                    {
                        'rafamadriz/friendly-snippets',
                        config = function()
                            require('luasnip.loaders.from_vscode').lazy_load()
                        end,
                    },
                },
            },
        },
        version = '1.*',
        opts = {
            keymap = { preset = 'default' },
            appearance = {
                nerd_font_variant = 'mono'
            },
            completion = {
                menu = { border = 'single' },
                documentation = { auto_show = true, auto_show_delay_ms = 200 }
            },
            snippets = { preset = "luasnip" },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },
            cmdline = {
                enabled = false,
            },
            fuzzy = { implementation = "lua" },
            signature = {
                enabled = true,
                window = { border = 'single' }
            },
        },
        opts_extend = { "sources.default" }
    }
}
