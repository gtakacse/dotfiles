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
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
            })
            lspconfig.ts_ls.setup({
                capabilities = capabilities,
            })
            lspconfig.pyright.setup({
                capabilities = capabilities,
                filetypes = { "python" },
            })

            lspconfig.rust_analyzer.setup({
                capabilities = capabilities,
                cmd = {
                    "rustup",
                    "run",
                    "stable",
                    "rust-analyzer",
                },
            })

            lspconfig.metals.setup({
                capabilities = capabilities,
            })

            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
                border = "rounded",
            })

            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Goto definition" })
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Goto implementation" })
            vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Goto reference" })
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
            vim.keymap.set("n", "<leader>eo", vim.diagnostic.open_float, { desc = "Open diagnostic window" })
            vim.keymap.set("n", "<leader>en", vim.diagnostic.goto_next, { desc = "Next diagnostic message" })
            vim.keymap.set("n", "<leader>ep", vim.diagnostic.goto_prev, { desc = "Prev diagnostic message" })
            vim.diagnostic.config({
                float = {
                    border = "rounded",
                },
            })
        end,
    },
}
