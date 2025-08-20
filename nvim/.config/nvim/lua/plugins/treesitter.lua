return {
    "nvim-treesitter/nvim-treesitter",
    branch = 'master',
    lazy = false,
    build = ":TSUpdate",
    config = function()
        local config = require("nvim-treesitter.configs")
        config.setup({
            auto_install = true,
            ensure_installed = { "lua", "vim", "vimdoc", "markdown", "markdown_inline", "python", "rust", "scala", "sql", "java" },
            highlight = {
                enable = true,
                -- disable = function(_, buf)
                --     local max_filesize = 100 * 1024 -- 100 KB
                --     local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                --     if ok and stats and stats.size > max_filesize then
                --         return true
                --     end
                -- end,
                disable = { 'vim', 'vimdoc', 'lua' },
                additional_vim_regex_highlighting = { 'ruby' },
            },
            indent = { enable = true, disable = { 'ruby' } },
        })
    end,
}
