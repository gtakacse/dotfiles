return {
    "github/copilot.vim",
    config = function()
        vim.keymap.set('i', '<C-A>', 'copilot#Accept("\\<CR>")', {
            expr = true,
            replace_keycodes = false
        })
        vim.keymap.set('i', '<C-W>', '<Plug>(copilot-accept-word)')
        vim.keymap.set('i', '<C-L>', '<Plug>(copilot-accept-line)')
        vim.keymap.set('i', '<C-J>', '<Plug>(copilot-next)')
        vim.keymap.set('i', '<C-K>', '<Plug>(copilot-prev)')
    end
}
