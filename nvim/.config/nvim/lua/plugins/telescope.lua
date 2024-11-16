return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-live-grep-args.nvim"
        },
        config = function()
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
            vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})

            require("telescope").load_extension("live_grep_args")
        end,
    },
}
