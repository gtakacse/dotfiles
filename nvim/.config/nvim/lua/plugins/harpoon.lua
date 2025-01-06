return {
    -- {{{ Harpoon lazy.vim specificaiton
    "ThePrimeagen/harpoon",
    enabled = true,
    branch = "harpoon2",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },

    -- }}}
    keys = function()
        local harpoon = require("harpoon")
        local conf = require("telescope.config").values

        local function toggle_telescope(harpoon_files)
            local file_paths = {}
            for _, item in ipairs(harpoon_files.items) do
                table.insert(file_paths, item.value)
            end
            require("telescope.pickers")
                .new({}, {
                    prompt_title = "Harpoon",
                    finder = require("telescope.finders").new_table({
                        results = file_paths,
                    }),
                    previewer = conf.file_previewer({}),
                    sorter = conf.generic_sorter({}),
                })
                :find()
        end

        return {
            -- Add and show list
            {
                "<leader>a",
                function()
                    harpoon:list():add()
                end,
                desc = "Harpoon file",
            },
            {
                "<C-e>",
                function()
                    harpoon.ui:toggle_quick_menu(harpoon:list())
                end,
                desc = "Harpoon toggle menu",
            },
            -- Harpoon marked files
            {
                "<a-j>",
                function()
                    harpoon:list():select(1)
                end,
                desc = "Harpoon buffer 1 ",
            },
            {
                "<a-k>",
                function()
                    harpoon:list():select(2)
                end,
                desc = "Harpoon buffer 2",
            },
            {
                "<a-l>",
                function()
                    harpoon:list():select(3)
                end,
                desc = "Harpoon buffer 3",
            },
            {
                "<a-;>",
                function()
                    harpoon:list():select(4)
                end,
                desc = "Harpoon buffer 4",
            },

            -- Harpoon next and previous
            {
                "<a-n>",
                function()
                    harpoon:list():next()
                end,
                desc = "Harpoon next buffer",
            },
            {
                "<a-p>",
                function()
                    harpoon:list():prev()
                end,
                desc = "Harpoon previous buffer",
            },
            {
                "<a-t>",
                function()
                    toggle_telescope(harpoon:list())
                end,
                desc = "Harpoon list in telescope window",
            },
        }
    end,

    opts = function(_, opts)
        opts.settings = {
            save_on_toggle = false,
            sync_on_ui_close = false,
            save_on_change = true,
            enter_on_sendcmd = false,
            tmux_autoclose_windows = false,
            excude_filetypes = { "harpoon", "alpha", "dashboard", "gitcommit" },
            mark_branch = false,
        }
    end,

    --- {{{ Configure Harpoon
    config = function(_, opts)
        require("harpoon").setup(opts)
    end,
    --- }}}
}
