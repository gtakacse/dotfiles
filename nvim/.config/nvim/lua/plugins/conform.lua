return {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
        {
            '<leader>fm',
            function()
                require('conform').format { async = true, lsp_format = 'fallback' }
            end,
            mode = '',
            desc = '[F]or[m]at buffer',
        }
    },
    opts = {
        notify_on_error = false,
        format_on_save = function(burnr)
            local disable_filetypes = { c = true, cpp = true }
            if disable_filetypes[vim.bo[burnr].filetype] then
                return nil
            else
                return {
                    timeout_ms = 500,
                    lsp_format = 'fallback'
                }
            end
        end,
        formatters_by_ft = {
            lua = { 'stylua' },
            python = { 'black' }, -- mypy, pyright, ruff
            javascript = { 'eslint_d' },
            typescript = { 'eslint_d' },
            sql = { 'prettierd' },
            markdown = { 'prettierd' },
            html = { 'prettierd' },
            json = { 'prettierd' },
            -- scala = { 'prettierd' }
        }
    }

}
