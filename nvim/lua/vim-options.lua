vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set relativenumber")
vim.cmd("set timeoutlen=1000")
vim.cmd("set ttimeoutlen=0")
vim.g.mapleader = " "
-- Generic key bindings
vim.keymap.set("i", "jk", "<esc>", {})
vim.keymap.set("n", "<esc><esc>", ":noh<CR><esc>", {})
vim.keymap.set("n", "<leader>x", ":bd<CR>", {})
