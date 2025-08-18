return {
    "github/copilot.vim",
    enabled = true,
    config = function()
        -- unset Tab for acceptin Copilot suggestions
        vim.cmd('let g:copilot_no_tab_map = v:true')
        vim.keymap.set('i', '<C-A>', 'copilot#Accept("\\<CR>")', {
            expr = true,
            replace_keycodes = false,
            noremap = true,
            desc = "Copilot Accept",
        })
        vim.keymap.set('i', '<C-W>', '<Plug>(copilot-accept-word)')
        vim.keymap.set('i', '<C-L>', '<Plug>(copilot-accept-line)')
        vim.keymap.set('i', '<C-J>', '<Plug>(copilot-next)')
        vim.keymap.set('i', '<C-K>', '<Plug>(copilot-prev)')
    end
}
