return {
    "dhruvasagar/vim-table-mode",
    config = function()
        vim.keymap.set("n", "<leader>tr", ":TableModeRealign<CR>", {})
    end,
}
