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
                        theme = "ivy",
                        path_display = { "truncate" },
                    },
                    live_grep = {
                        theme = "ivy",
                        path_display = { "truncate" },
                    },
                    live_grep_args = {
                        theme = "ivy",
                        path_display = "truncate",
                    },
                    buffers = {
                        theme = "dropdown",
                        previewer = false,
                        path_display = { "truncate" },
                    },
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
            vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
            vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help tags" })
            vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find open buffers" })
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
            end, { desc = "Live grep" })
            vim.keymap.set("n", "<leader>fw", live_grep_args_shortcuts.grep_word_under_cursor,
                { desc = "Live grep word under cursor" })
            vim.keymap.set("n", "<leader>fs", builtin.git_files, { desc = "Find git files" })
        end,
    },
}
