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
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
            { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        }
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

                    map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
                    map('gra', vim.lsp.buf.code_action, 'Code Action', { 'n', 'x' })
                    map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
                    map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
                    map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [Definition')
                    map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
                    map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definitino')
                    map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')
                    map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbol')
                end
            })

            local servers = {
                lua_ls = {
                    settings = {
                        Lua = {
                            diagnostic = { disable = { 'missing-fields' } }
                        },
                    }
                },
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
