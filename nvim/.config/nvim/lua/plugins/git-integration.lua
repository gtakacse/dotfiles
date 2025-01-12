return {
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup {
                on_attach = function(bufnr)
                    local gitsigns = require('gitsigns')

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    --Navigation
                    map('n', ']c', function()
                        if vim.wo.diff then
                            vim.cmd.normal({ ']c', bang = true })
                        else
                            gitsigns.next_hunk()
                        end
                    end)

                    map('n', '[c', function()
                        if vim.wo.diff then
                            vim.cmd.normal({ '[c', bang = true })
                        else
                            gitsigns.prev_hunk()
                        end
                    end)

                    map('n', '<leader>hs', gitsigns.stage_hunk, { desc = "Stage hunk" })
                    map('n', '<leader>hr', gitsigns.reset_hunk, { desc = "Reset hunk" })
                    map('n', '<leader>hS', gitsigns.stage_buffer, { desc = "Stage buffer" })
                    map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = "Unstage hunk" })
                    map('n', '<leader>hR', gitsigns.reset_buffer, { desc = "Reset buffer" })
                    map('n', '<leader>hp', gitsigns.preview_hunk, { desc = "Preview hunk" })
                    map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = "Blame line" })
                end
            }
        end
    },
    {
        "tpope/vim-fugitive"
    }
}
