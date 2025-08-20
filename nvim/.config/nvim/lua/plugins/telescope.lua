return {
    {
        'nvim-telescope/telescope.nvim',
        -- tag = '0.1.8',
        dependencies = {
            'nvim-lua/plenary.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
            'nvim-telescope/telescope-ui-select.nvim',
        },

        config = function()
            require('telescope').setup({
                pickers = {
                    find_files = {
                        theme = 'ivy',
                        path_display = { 'truncate' },
                    },
                    live_grep = {
                        theme = 'ivy',
                        path_display = { 'truncate' },
                    },
                    live_grep_args = {
                        theme = 'ivy',
                        path_display = 'truncate',
                    },
                },
                extensions = {
                    fzf = {},
                    ['ui-select'] = {
                        require('telescope.themes').get_dropdown(),
                    },
                }

            })

            pcall(require('telescope').load_extension('fzf'))
            pcall(require('telescope').load_extension('ui-select'))

            -- custom rg plugin
            -- require('telescope.multigrep').setup()

            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
            vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
            vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
            vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
            vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
            vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
            vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
            vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
            vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files' })
            vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
            vim.keymap.set('n', '<leader>/', function()
                builtin.current_buffer_fuzzy_find(
                    require('telescope.themes').get_dropdown({
                        winblend = 10,
                        previewer = false,
                        path_display = { 'truncate' },
                    })
                )
            end, { desc = '[/] Fuzzy search current buffer' })
            vim.keymap.set('n', '<leader>s/', function()
                builtin.live_grep {
                    grep_open_files = true,
                    prompt_title = 'Live Grep in Open Files',
                }
            end, { desc = 'Search [/] in Open Files' })
            vim.keymap.set('n', '<leader>sn', function()
                builtin.find_files { cwd = vim.fn.stdpath 'config' }
            end, { desc = '[S]earch [N]eovim Files' })
        end,
    },
}
