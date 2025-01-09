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
        dashboard = { enabled = true },
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
        }
    }
}
