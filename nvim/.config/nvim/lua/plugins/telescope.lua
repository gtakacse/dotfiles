return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-live-grep-args.nvim",
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        },
        config = function()
            require('telescope').setup({
                pickers = {
                    find_files = {
                        theme = "ivy"
                    }
                },
                extensions = {
                    fzf = {},
                }

            })

            require('telescope').load_extension('fzf')
            require("telescope").load_extension("live_grep_args")

            require("telescope.multigrep").setup()

            local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
            vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
            vim.keymap.set("n", "<leader>fg", function()
                local opts = {
                    layout_strategy = 'horizontal',
                    layout_config = {
                        horizontal = {
                            width = 0.85,
                        }
                    },
                }
                -- builtin.live_grep(opts)
                require("telescope").extensions.live_grep_args.live_grep_args(opts)
            end, {})
            vim.keymap.set("n", "<leader>fw", live_grep_args_shortcuts.grep_word_under_cursor)
            vim.keymap.set("n", "<leader>fs", builtin.git_files, {})
        end,
    },
}
