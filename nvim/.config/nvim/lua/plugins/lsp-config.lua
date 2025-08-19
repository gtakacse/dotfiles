return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({})
        end,
        opts = {
            ensure_installed = { "black", "debugpy", "mypy", "ruff", "pyright" },
        },
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "ts_ls", "pyright" },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            'saghen/blink.cmp',
        },
        config = function()
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('custom-lsp-attach', { clear = true }),
                callback = function(event)
                    local map = function(keys, func, desc, mode)
                        mode = mode or 'n'
                        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                    end

                    map('K', vim.lsp.buf.hover, 'Hover Open')
                    map('gd', vim.lsp.buf.definition, 'Goto Definition')
                    map('gi', vim.lsp.buf.implementation, 'Goto Implementation')
                    map('gr', vim.lsp.buf.references, 'Goto Referencies')
                    map('<leader>ca', vim.lsp.buf.code_action, 'Code action')
                    -- Defaults
                    -- map('grd', vim.lsp.buf.definition, 'Goto definition')
                    -- map('grt', vim.lsp.buf.type_definition, 'Goto Type Definition')
                    -- map('gri', vim.lsp.buf.implementation, 'Goto Implementation')
                    -- map('grr', vim.lsp.buf.references, 'Goto Referencies')
                    -- map('gra', vim.lsp.buf.code_action, 'Code action')
                    map('<leader>eo', vim.diagnostic.open_float, 'Open Diagnostics Window')
                    map('<leader>en', vim.diagnostic.goto_next, 'Next Diagnostics Message')
                    map('<leader>ep', vim.diagnostic.goto_prev, 'Previous Diagnostics Message')
                end
            })

            vim.diagnostic.config({
                float = {
                    border = "rounded",
                },
            })

            local servers = {
                lua_ls = {},
                pyright = {
                },
                ts_ls = {},
                rust_analyzer = {
                    cmd = {
                        "rustup",
                        "run",
                        "stable",
                        "rust-analyzer",
                    }
                },
                -- metals = {},
            }

            local lspconfig = require("lspconfig")
            local capabilities = require('blink.cmp').get_lsp_capabilities()
            for server_name, server in pairs(servers) do
                server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                lspconfig[server_name].setup(server)
            end
        end,
    },
}
