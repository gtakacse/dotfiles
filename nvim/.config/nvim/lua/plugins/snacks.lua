return {
    "folke/snacks.nvim",
    lazy = false,
    opts = {
        bigfile = {
            enabled = true,
            notify = true,
            size = 100 * 1024,
        },
        bufdelete = { enabled = true },
        dashboard = {
            enabled = true,
            sections = {
                { section = "header" },
                { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
                { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
                { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
                { section = "startup" },
            },
        },
        indent = {
            enabled = true,
            animate = {
                enabled = false,
            }
        },
        notifier = { enabled = true, timeout = 2000 },
        quickfile = { enabled = true },
        lazygit = { enabled = true },
        scope = {
            enabled = true,
            textobject = {
                ii = {
                    min_size = 2,
                    edge = false,
                    cursor = false,
                    treesitter = {
                        blocks = { enabled = false }
                    },
                    desc = 'inner scope'
                },
                ai = {
                    cursor = false,
                    min_size = 2,
                    treesitter = {
                        blocks = { enabled = false }
                    },
                    desc = "full scope"
                },
            },
            jump = {
                ["[a"] = {
                    min_scope = 1,
                    bottom = false,
                    cursor = false,
                    edge = true,
                    treesitter = {
                        blocks = { enabled = false }
                    },
                    desc = "jump to top of the scope"
                },
                ["]a"] = {
                    min_size = 1,
                    bottom = true,
                    cursor = false,
                    edge = true,
                    treesitter = {
                        blocks = { enabled = true }
                    },
                    desc = "jump to the bottom of the scope"
                }
            }
        },
        terminal = {
            enabled = true,
        },
        styles = {
        },
    },
    keys = {
        { "<leader>xc", function() require("snacks").bufdelete() end,       desc = "Delete current buffer" },
        { "<leader>xa", function() require("snacks").bufdelete.all() end,   desc = "Delete all buffers" },
        { "<leader>x-", function() require("snacks").bufdelete.other() end, desc = "Delete all other buffers" },
        { "<leader>lg", function() require("snacks").lazygit() end,         desc = "Open Lazygit" },
        { "<leader>gb", function() require("snacks").git.blame_line() end,  desc = "Open git blame in window" },
        { "<leader>to", function() require("snacks").terminal() end,        desc = "Open termina" },
    }
}
